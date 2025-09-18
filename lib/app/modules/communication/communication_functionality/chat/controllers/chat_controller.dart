import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
import '../../../../../data/network/communication/chat/chat_service.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class ChatController extends GetxController {
  final SocketService _socketService = SocketService();

  // Reactive variables
  var isConnected = false.obs;
  var isLoading = true.obs;
  var events = <SocketEvent>[].obs;
  var messages = <ChatMessage>[].obs;
  var unreadCount = <String, int>{}.obs;
  var userStatus = <String, Map<String, dynamic>>{}.obs;
  var connectionError = RxString('');
  RxString currentUserId = ''.obs;
  RxString receiverId = ''.obs;
  var typingStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  Future<void> _initController() async {
    isLoading.value = true;
    try {
      final user = await SecureStorage.getUserData();
      if (user != null) {
        currentUserId.value = user.id!;
      }
    } catch (e) {
      connectionError.value = 'Failed to initialize: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Connect to socket with your userId
  void connect(String url, {Map<String, dynamic>? query, String? userId}) {
    if (currentUserId.value.isEmpty) {
      connectionError.value = 'User ID not set';
      return;
    }

    // isLoading.value = true;
    connectionError.value = '';

    _socketService.connect(
      url,
      query: query,
      userId: userId!, // required for server to know your ID
    );

    _socketService.events.listen(
      (event) {
        events.add(event);
        print('📱 Event received: ${event.type}');

        switch (event.type) {
          case 'connect':
            isConnected.value = true;
            connectionError.value = '';
            // _initializeChat();
            break;

          case 'disconnect':
            isConnected.value = false;
            break;

          case 'error':
            connectionError.value = event.data?.toString() ?? 'Unknown error';
            break;

          case 'users_status':
            try {
              if (event.data is Map<String, dynamic>) {
                final data = event.data as Map<String, dynamic>;

                if (data.containsKey('userStatus')) {
                  // Cast each entry value to Map<String, dynamic>
                  final casted = Map<String, Map<String, dynamic>>.fromEntries(
                    (data['userStatus'] as Map<String, dynamic>).entries.map(
                      (e) => MapEntry(e.key, e.value as Map<String, dynamic>),
                    ),
                  );

                  userStatus.value = casted;
                  userStatus.refresh();
                }

                print("📡 Updated user statuses: ${jsonEncode(userStatus)}");
              } else {
                print("❌ Invalid users_status format: ${event.data}");
              }
            } catch (e) {
              print("❌ Error handling users_status: $e");
            }
            break;

          case 'receive_message':
            _processIncomingMessage(event.data);
            break;

          case 'conversations_received':
            try {
              if (event.data is Map<String, dynamic>) {
                _handleConversationsReceived(event.data);
              } else {
                print('❌ Invalid conversations data format: ${event.data}');
              }
            } catch (e) {
              print('❌ Error processing conversations: $e');
            }
            break;

          case 'user_typing':
            handleTypingEvent(event.data);
            break;

          case 'message_status_updated':
            handleUpdatedMessageStatus(event.data);
            break;

          default:
            break;
        }
      },
      onError: (error) {
        connectionError.value = 'Socket error: $error';
        print('❌ Socket stream error: $error');
      },
    );
  }

  void handleTypingEvent(Map<String, dynamic> data) {
    final userId = data['userId'];
    final isTyping = data['isTyping'] ?? false;
    typingStatus[userId] = isTyping;
  }

  void handleUpdatedMessageStatus(Map<String, dynamic> data) {
    try {
      final messageId = data['message_id'];
      final statusStr = data['status'];
      final status = MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == statusStr,
        orElse: () => MessageStatus.sent,
      );

      final index = messages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        final updated = messages[index].copyWith(status: status);
        messages[index] = updated;
        messages.refresh();
      }
    } catch (e) {
      print('❌ Error updating message status: $e');
    }
  }

  Future<void> _processIncomingMessage(dynamic data) async {
    try {
      final messageData = data is String ? jsonDecode(data) : data;
      final msgJson = messageData['message'] ?? messageData;
      final receiverId = messageData['user_id'];
      final msg = ChatMessage.fromJson(msgJson, conversationId: receiverId);
      if (msg.status == MessageStatus.delivered) {
        unreadCount[receiverId] = (unreadCount[receiverId] ?? 0) + 1;
      }

      if (!messages.any((m) => m.id == msg.id)) {
        messages.insert(0, msg);
      }
    } catch (e) {
      print('❌ Error processing incoming message: $e');
    }
  }

  void markMessageAsRead(String senderId, String receiverId) {
    try {
      final receipt = ReadReceipt(senderId: senderId, receiverId: receiverId);
      unreadCount[receiverId] = 0;

      _socketService.markMessagesRead(receipt);
    } catch (e) {
      print('❌ Error marking message as read: $e');
    }
  }

  Future<void> _handleConversationsReceived(Map<String, dynamic> data) async {
    isLoading.value = true;
    messages.clear(); // Clear existing messages before adding history

    data.forEach((receiverId, msgs) {
      if (msgs is List) {
        for (var msgJson in msgs) {
          final msg = ChatMessage.fromJson(msgJson, conversationId: receiverId);

          if (msg.status == MessageStatus.delivered) {
            unreadCount[receiverId] = (unreadCount[receiverId] ?? 0) + 1;
          }

          if (!messages.any((m) => m.id == msg.id)) {
            messages.add(msg);
          }
        }
      }
      isLoading.value = false;
    });

    // Sort messages by timestamp, newest first
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void disconnect() {
    _socketService.disconnect();
    isConnected.value = false;
    connectionError.value = '';
  }

  void sendMessage(ChatMessage msg) {
    _socketService.sendMessage(msg);
    messages.insert(0, msg);
  }

  void sendFileChat(UploadChatFilesRequest file) =>
      _socketService.sendFileChat(file);

  void getConversations(String userId) =>
      _socketService.getConversations(userId);

  void sendTyping(TypingEvent typing) => _socketService.sendTyping(typing);

  @override
  void onClose() {
    messages.clear();
    _socketService.dispose();
    super.onClose();
  }
}
