import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
import '../../../../../widgets/common/display/crm_card.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String receiverId;

  const ChatScreen({
    Key? key,
    required this.userId,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  Rxn<File> selectedFile = Rxn<File>();

  @override
  void initState() {
    super.initState();
    _initChat();
  }

  void _initChat() {
    controller.connect(
      'https://api.raiser.in',
      query: {'userId': widget.userId}
    );
    controller.initChat(widget.userId, widget.receiverId);
  }

  @override
  void dispose() {
    controller.messages.clear();
    controller.disconnect();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        // Check file size (limit to 10MB)
        if (await file.length() > 10 * 1024 * 1024) {
          Get.snackbar(
            'Error',
            'File size must be less than 10MB',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        selectedFile.value = file;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to select file: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendMessage() {
    final messageText = messageController.text.trim();
    final file = selectedFile.value;

    if (messageText.isEmpty && file == null) return;

    try {
      // Handle file upload first if present
      if (file != null) {
        final name = file.path.split('/').last;
        final type = name.contains('.') ? name.split('.').last : 'unknown';
        final size = file.lengthSync();
        final bytes = file.readAsBytesSync();

        final chatFile = ChatFile(
          name: name,
          type: type,
          size: size,
          data: base64Encode(bytes),
        );

        controller.sendFileChat(chatFile);
        selectedFile.value = null;
      }

      // Send text message if present
      if (messageText.isNotEmpty) {
        final msg = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          receiverId: widget.receiverId,
          status: MessageStatus.sent,
          senderId: widget.userId,
          message: messageText,
          timestamp: DateTime.now(),
        );

        controller.sendMessage(msg);
        messageController.clear();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          Obx(() => Container(
            margin: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.circle,
              size: 12,
              color: controller.isConnected.value ? Colors.green : Colors.red,
            ),
          ))
        ],
      ),
      body: Column(
        children: [
          // Error banner
          Obx(() {
            final error = controller.connectionError.value;
            if (error.isEmpty) return const SizedBox.shrink();

            return Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(child: Text(error, style: const TextStyle(color: Colors.red))),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _initChat,
                  )
                ],
              ),
            );
          }),

          // Messages
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CrmLoadingCircle());
              }

              final chatMessages = controller.messages
                  .where((m) =>
                    (m.senderId == widget.userId && m.receiverId == widget.receiverId) ||
                    (m.senderId == widget.receiverId && m.receiverId == widget.userId))
                  .toList();

              // if (chatMessages.isEmpty) {
              //   return Center(
              //     child: Text(
              //       'No messages yet',
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //         color: Colors.grey,
              //       ),
              //     ),
              //   );
              // }

              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.all(10),
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  final isMe = message.senderId == widget.userId;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _formatTime(message.timestamp),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isMe ? Colors.white70 : Colors.black45,
                                ),
                              ),
                              if (isMe) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  message.status == MessageStatus.read
                                      ? Icons.done_all
                                      : Icons.done,
                                  size: 12,
                                  color: message.status == MessageStatus.read
                                      ? Colors.blue[100]
                                      : Colors.white70,
                                )
                              ]
                            ],
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
            final typingEvents = controller.events.where((e) =>
                e.type == 'typing' &&
                e.data['senderId'] == widget.receiverId &&
                e.data['receiverId'] == widget.userId);

            if (typingEvents.isEmpty) return const SizedBox.shrink();

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    child: const CrmLoadingCircle(),
                  ),
                  const Text('Partner is typing...'),
                ],
              ),
            );
          }),

          // Input
          CrmCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() {
                    if (selectedFile.value == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.attach_file, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedFile.value!.path.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => selectedFile.value = null,
                          ),
                        ],
                      ),
                    );
                  }),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
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
                                senderId: widget.userId,
                                receiverId: widget.receiverId,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: selectFile,
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: Colors.blue,
                        onPressed: sendMessage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (date == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return 'Yesterday ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
