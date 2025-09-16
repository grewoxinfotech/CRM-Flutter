// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
// import 'package:get/get.dart';
// import '../../../../../data/network/communication/chat/chat_model.dart';
// import '../../../../../data/network/communication/chat/chat_service.dart';
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
//   onInit() {
//     init();
//     super.onInit();
//   }
//
//   Future<void> init() async {
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
//     _socketService.events.listen((event) {
//       events.add(event);
//
//       if (event.type == 'connect') isConnected.value = true;
//       if (event.type == 'disconnect') isConnected.value = false;
//
//       // Handle incoming messages
//       if (event.type == 'receive_message') {
//         final msg = ChatMessage.fromJson(event.data);
//         messages.add(msg);
//       }
//       if (currentUserId.value != null && currentUserId.value.isNotEmpty) {
//         getConversations(currentUserId.value);
//       }
//
//       // Handle conversations_received (initial fetch)
//       if (event.type == 'conversations_received') {
//         final data = event.data as Map<String, dynamic>;
//         data.forEach((conversationId, msgs) {
//           for (var msgJson in msgs) {
//             final msg = ChatMessage.fromJson(msgJson);
//             messages.add(msg);
//           }
//         });
//       }
//     });
//   }
//
//   // Disconnect
//   void disconnect() {
//     _socketService.disconnect();
//     isConnected.value = false;
//   }
//
//   // Join private room
//   void joinRoom(String userId) => _socketService.joinRoom(userId);
//
//   // Send private message
//   // void sendMessage(ChatMessage message) => _socketService.sendMessage(message);
//   void sendMessage(ChatMessage message) {
//     _socketService.sendMessage(message);
//     messages.add(message); // optimistic update
//   }
//
//   // Get conversations
//   void getConversations(String userId) =>
//       _socketService.getConversations(userId);
//
//   // Update message status
//   void updateMessageStatus(Map<String, dynamic> data) =>
//       _socketService.updateMessageStatus(data);
//
//   // Delete message
//   void deleteMessage(Map<String, dynamic> data) =>
//       _socketService.deleteMessage(data);
//
//   // Typing indicator
//   void sendTyping(TypingEvent typing) => _socketService.sendTyping(typing);
//
//   // Group chat
//   void createGroup(Map<String, dynamic> groupData) =>
//       _socketService.createGroup(groupData);
//
//   void joinGroup(String groupId, String userId) =>
//       _socketService.joinGroup(groupId, userId);
//
//   void leaveGroup(String groupId, String userId) =>
//       _socketService.leaveGroup(groupId, userId);
//
//   void sendGroupMessage(String groupId, Map<String, dynamic> message) =>
//       _socketService.sendGroupMessage(groupId, message);
//
//   void markMessagesAsRead(Map<String, dynamic> data) =>
//       _socketService.markMessagesAsRead(data);
//
//   // Upload files
//   Future<dynamic> sendFiles(Map<String, dynamic> data) =>
//       _socketService.sendFiles(data);
//
//   @override
//   void onClose() {
//     _socketService.dispose();
//     super.onClose();
//   }
// }

import 'package:get/get.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
import '../../../../../data/network/communication/chat/chat_service.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class ChatController extends GetxController {
  final SocketService _socketService = SocketService();

  // Reactive variables
  var isConnected = false.obs;
  var events = <SocketEvent>[].obs;
  var messages = <ChatMessage>[].obs;
  RxString currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  Future<void> initController() async {
    final user = await SecureStorage.getUserData();
    if (user != null) {
      currentUserId.value = user.id!;
    }
  }

  // Connect to socket
  void connect(String url, {Map<String, dynamic>? query}) {
    _socketService.connect(url, query: query);

    _socketService.events.listen((event) {
      events.add(event);

      if (event.type == 'connect') {
        isConnected.value = true;
        // Fetch previous conversations once after connecting
        if (currentUserId.value.isNotEmpty) {
          getConversations(currentUserId.value);
          joinRoom(currentUserId.value);
        }
      }

      if (event.type == 'disconnect') isConnected.value = false;

      // Incoming private message
      if (event.type == 'receive_message') {
        final msg = ChatMessage.fromJson(event.data);
        messages.add(msg);
      }

      // Previous conversations received
      if (event.type == 'conversations_received') {
        final data = event.data as Map<String, dynamic>;
        data.forEach((conversationId, msgs) {
          for (var msgJson in msgs) {
            final msg = ChatMessage.fromJson(msgJson);
            messages.add(msg);
          }
        });
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
    });
  }

  void disconnect() {
    _socketService.disconnect();
    isConnected.value = false;
  }

  void joinRoom(String userId) => _socketService.joinRoom(userId);

  void sendMessage(ChatMessage message) {
    _socketService.sendMessage(message);
    messages.add(message); // optimistic update
  }

  void getConversations(String userId) =>
      _socketService.getConversations(userId);

  void sendTyping(TypingEvent typing) => _socketService.sendTyping(typing);

  @override
  void onClose() {
    _socketService.dispose();
    super.onClose();
  }
}
