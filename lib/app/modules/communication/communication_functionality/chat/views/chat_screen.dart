import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final String userId; // current user id
  final String receiverId; // chat partner id
  final TextEditingController messageController = TextEditingController();

  ChatScreen({required this.userId, super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    // Connect socket when screen opens
    controller.connect('https://api.raiser.in', query: {'userId': userId});
    controller.joinRoom(userId);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          // Messages list
          // Expanded(
          //   child: Obx(() {
          //     final messages =
          //         controller.events
          //             .where(
          //               (e) =>
          //                   e.type == 'receive_message' ||
          //                   e.type == 'send_message',
          //             )
          //             .toList();
          //
          //     return ListView.builder(
          //       reverse: true,
          //       padding: const EdgeInsets.all(10),
          //       itemCount: messages.length,
          //       itemBuilder: (context, index) {
          //         final event = messages[messages.length - 1 - index];
          //         final message = ChatMessage.fromJson(event.data);
          //         final isMe = message.senderId == userId;
          //
          //         return Align(
          //           alignment:
          //               isMe ? Alignment.centerRight : Alignment.centerLeft,
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //               vertical: 8,
          //               horizontal: 12,
          //             ),
          //             margin: const EdgeInsets.symmetric(vertical: 4),
          //             decoration: BoxDecoration(
          //               color: isMe ? Colors.blueAccent : Colors.grey[300],
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             child: Column(
          //               crossAxisAlignment:
          //                   isMe
          //                       ? CrossAxisAlignment.end
          //                       : CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   message.message,
          //                   style: TextStyle(
          //                     color: isMe ? Colors.white : Colors.black87,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 4),
          //                 Text(
          //                   _formatTime(message.timestamp),
          //                   style: TextStyle(
          //                     fontSize: 10,
          //                     color: isMe ? Colors.white70 : Colors.black45,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   }),
          // ),
          Expanded(
            child: Obx(() {
              final chatMessages =
                  controller.messages
                      .where(
                        (m) =>
                            m.senderId == userId || m.receiverId == receiverId,
                      )
                      .toList();

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(10),
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[chatMessages.length - 1 - index];
                  final isMe = message.senderId == userId;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatTime(message.timestamp),
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe ? Colors.white70 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Typing indicator
          Obx(() {
            final typingEvents =
                controller.events.where((e) => e.type == 'typing').toList();
            if (typingEvents.isEmpty) return const SizedBox.shrink();

            final typingUsers =
                typingEvents
                    .map((e) => e.data['userName'] ?? 'Someone')
                    .toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text('${typingUsers.join(", ")} is typing...'),
            );
          }),

          // Message input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text input
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (text) {
                      controller.sendTyping(
                        TypingEvent(
                          isTyping: text.isNotEmpty,
                          senderId: userId,
                          receiverId: receiverId,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // Send button
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: () {
                    final messageText = messageController.text.trim();
                    if (messageText.isEmpty) return;

                    final msg = ChatMessage(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      receiverId: receiverId,
                      status: MessageStatus.sent,
                      senderId: userId,
                      message: messageText,
                      timestamp: DateTime.now(),
                    );

                    controller.sendMessage(msg);
                    messageController.clear();
                  },
                ),

                // Optional file button
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // TODO: Implement file picking & send
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final time = timestamp.toLocal();
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
