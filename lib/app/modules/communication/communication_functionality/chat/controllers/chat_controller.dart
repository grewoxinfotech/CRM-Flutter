//
//
// import 'package:get/get.dart';
// import '../../../../../data/network/communication/chat/chat_model.dart';
// import '../../../../../data/network/communication/chat/chat_service.dart';
// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
//
// class ChatController extends GetxController {
//   final SocketService _socketService = SocketService();
//
//   // Reactive variables
//   var isConnected = false.obs;
//   var events = <SocketEvent>[].obs;
//   var messages = <ChatMessage>[].obs;
//   RxString currentUserId = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initController();
//   }
//
//   Future<void> initController() async {
//     final user = await SecureStorage.getUserData();
//     if (user != null) {
//       currentUserId.value = user.id!;
//     }
//   }
//
//   // Connect to socket
//   void connect(String url, {Map<String, dynamic>? query}) {
//     _socketService.connect(url, query: query);
//
//
//
//     _socketService.events.listen((event) {
//       events.add(event);
//
//       if (event.type == 'connect') {
//         isConnected.value = true;
//         // Fetch previous conversations once after connecting
//
//       }
//
//       if (event.type == 'disconnect') isConnected.value = false;
//
//       // Incoming private message
//       if (event.type == 'receive_message') {
//         final msg = ChatMessage.fromJson(event.data);
//         messages.add(msg);
//       }
//
//       // Previous conversations received
//       if (event.type == 'conversations_received') {
//         final data = event.data as Map<String, dynamic>;
//         data.forEach((conversationId, msgs) {
//           for (var msgJson in msgs) {
//             final msg = ChatMessage.fromJson(msgJson);
//             messages.add(msg);
//           }
//         });
//         messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//       }
//     });
//   }
//
//   void disconnect() {
//     _socketService.disconnect();
//     isConnected.value = false;
//   }
//
//   void joinRoom(String userId) => _socketService.joinRoom(userId);
//
//   void sendMessage(ChatMessage message) {
//     _socketService.sendMessage(message);
//     messages.add(message); // optimistic update
//   }
//
//   void getConversations(String userId) =>
//       _socketService.getConversations(userId);
//
//   void sendTyping(TypingEvent typing) => _socketService.sendTyping(typing);
//
//   @override
//   void onClose() {
//     _socketService.dispose();
//     super.onClose();
//   }
// }

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
  var connectionError = RxString('');
  RxString currentUserId = ''.obs;
  RxString receiverId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  Future<void> initController() async {
    try {
      isLoading.value = true;
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

  /// Connect to socket and start listening for events
  void connect(String url, {Map<String, dynamic>? query}) {
    try {
      isLoading.value = true;
      connectionError.value = '';

      _socketService.connect(
        url,
        query: {
          ...?query,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        }
      );

      _socketService.events.listen(
        (event) {
          events.add(event);
          print('📱 Controller received event: ${event.type}');

          switch (event.type) {
            case 'connect':
              isConnected.value = true;
              connectionError.value = '';
              if (currentUserId.isNotEmpty) {
                _initializeChat();
              }
              break;

            case 'disconnect':
              isConnected.value = false;
              break;

            case 'error':
              connectionError.value = event.data?.toString() ?? 'Unknown error';
              break;

            case 'receive_message':
              try {
                print('📱 Processing received message: ${jsonEncode(event.data)}');
                final msg = ChatMessage.fromJson(
                  event.data is String
                    ? jsonDecode(event.data)
                    : event.data
                );
                _handleNewMessage(msg);
              } catch (e) {
                print('❌ Error processing message: $e');
                print('Message data was: ${event.data}');
              }
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
          }
        },
        onError: (error) {
          print('❌ Socket stream error: $error');
          connectionError.value = 'Connection error: $error';
        },
      );
    } catch (e) {
      print('❌ Connection error: $e');
      connectionError.value = 'Connection error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Initialize chat with user IDs
  void initChat(String userId, String toUserId) {
    currentUserId.value = userId;
    receiverId.value = toUserId;
    _initializeChat();
  }

  void _initializeChat() {
    try {
      // Join private chat room (combine IDs to create unique room)
      final roomId = "${currentUserId.value}_${receiverId.value}";
      print('🔄 Joining chat room: $roomId');
      joinRoom(roomId);

      // Get existing conversations
      getConversations(currentUserId.value);

      // Clear any previous errors
      connectionError.value = '';
    } catch (e) {
      print('❌ Error initializing chat: $e');
      connectionError.value = 'Failed to initialize chat: $e';
    }
  }

  void _handleNewMessage(ChatMessage msg) {
    try {
      print('📱 Handling new message: ${jsonEncode(msg.toJson())}');

      // Only add if message doesn't already exist
      if (!messages.any((m) => m.id == msg.id)) {
        messages.insert(0, msg); // Add to start of list for newest first
        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        // Update message status if needed
        if (msg.receiverId == currentUserId.value) {
          _markMessageAsRead(msg);
        }
      }
    } catch (e) {
      print('❌ Error handling new message: $e');
    }
  }

  void _markMessageAsRead(ChatMessage message) {
    try {
      final readReceipt = ReadReceipt(
        senderId: currentUserId.value,
        receiverId: message.senderId,
      );
      // _socketService.emit('mark_messages_read', readReceipt.toJson());
    } catch (e) {
      print('❌ Error marking message as read: $e');
    }
  }

  void _handleConversationsReceived(Map<String, dynamic> data) {
    messages.clear(); // Clear existing messages before adding history

    data.forEach((receiverId, msgs) {
      if (msgs is List) {
        for (var msgJson in msgs) {
          msgJson['receiver_id'] = receiverId;
          final msg = ChatMessage.fromJson(msgJson);

          // Only add if message doesn't already exist
          if (!messages.any((m) => m.id == msg.id)) {
            messages.add(msg);
          }
        }
      }
    });

    // Sort messages by timestamp, newest first
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void disconnect() {
    _socketService.disconnect();
    isConnected.value = false;
    connectionError.value = '';
  }

  void joinRoom(String userId) => _socketService.joinRoom(userId);

  void sendMessage(ChatMessage message) {
    try {
      _socketService.sendMessage(message);
      _handleNewMessage(message); // Optimistic update
    } catch (e) {
      print('Error sending message: $e');
      // You could add error handling here, like showing a snackbar
    }
  }

  void sendFileChat(ChatFile data) {
    try {
      _socketService.sendFileChat(data);
    } catch (e) {
      print('Error sending file: $e');
      // You could add error handling here
    }
  }

  void getConversations(String userId) => _socketService.getConversations(userId);

  void sendTyping(TypingEvent typing) => _socketService.sendTyping(typing);

  @override
  void onClose() {
    messages.clear();
    _socketService.dispose();
    super.onClose();
  }
}
