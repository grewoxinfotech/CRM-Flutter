import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
import '../../../../../widgets/common/display/crm_card.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String receiverId;
  final String receiverName;
  final ChatController chatController;

  const ChatScreen({
    Key? key,
    required this.userId,
    required this.receiverId,
    required this.chatController,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? _typingTimer;
  // final ChatController widget.chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  Rxn<File> selectedFile = Rxn<File>();

  @override
  void initState() {
    super.initState();
    widget.chatController.markMessageAsRead(widget.userId,widget.receiverId);
    // _initChat();
  }

  void _initChat() {
    widget.chatController.connect(
      'https://api.raiser.in',
      query: {'userId': widget.userId},
      userId: widget.userId,
    );
    // widget.chatController.initChat(widget.userId, widget.receiverId);
  }

  @override
  void dispose() {
    // widget.chatController.messages.clear();
    // widget.chatController.disconnect();
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

  // void sendMessage() {
  //   final messageText = messageController.text.trim();
  //   final file = selectedFile.value;
  //
  //   if (messageText.isEmpty && file == null) return;
  //
  //   try {
  //     // Handle file upload first if present
  //     if (file != null) {
  //       final name = file.path.split('/').last;
  //       final extension = name.contains('.') ? name.split('.').last : 'unknown';
  //       final type = "image/$extension"; // or use lookupMimeType() for accuracy
  //       final size = await file.length();
  //       final bytes = await file.readAsBytes();
  //
  //       final chatFile = UploadChatFilesRequest(
  //         file: FileMeta(placeholder: true, num: 0), // required field
  //         name: name,
  //         type: type,
  //         size: size,
  //         data: base64Encode(bytes),
  //       );
  //
  //       widget.chatController.sendFileChat(chatFile);
  //       selectedFile.value = null;
  //     }
  //
  //     // Send text message if present
  //     if (messageText.isNotEmpty) {
  //       final msg = ChatMessage(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         receiverId: widget.receiverId,
  //         status: MessageStatus.sent,
  //         senderId: widget.userId,
  //         message: messageText,
  //         timestamp: DateTime.now(),
  //       );
  //
  //       widget.chatController.sendMessage(msg);
  //       messageController.clear();
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to send message: $e',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    final file = selectedFile.value;

    if (messageText.isEmpty && file == null) return;

    try {
      // Handle file upload first if present
      if (file != null) {
        final name = file.path.split('/').last;
        final extension = name.contains('.') ? name.split('.').last : 'unknown';
        final type = "image/$extension"; // or use lookupMimeType(file.path)
        final size = await file.length();
        final bytes = await file.readAsBytes();

        final chatFile = ChatFile(
          file: FileMeta(placeholder: true, num: 0),
          name: name,
          type: type,
          size: size,
          data: base64Encode(bytes),
        );

        final uploadRequest = UploadChatFilesRequest(
          files: [chatFile],               // must be a list
          senderId: widget.userId,
          receiverId: widget.receiverId,
          message: messageText.isEmpty ? "" : messageText,
        );

        widget.chatController.sendFileChat(uploadRequest);
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

        widget.chatController.sendMessage(msg);
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
        backgroundColor: ColorRes.primary,
        foregroundColor: ColorRes.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.receiverName,
              style: TextStyle(color: ColorRes.white),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.small),
            Obx(() {
              final isTyping =
                  widget.chatController.typingStatus[widget.receiverId] ??
                  false;
              if (!isTyping) return const SizedBox.shrink();
              return Text(
                'typing...',
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              );
            }),
          ],
        ),

        actions: [
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Icon(
                Icons.circle,
                size: 12,
                color:
                    widget.chatController.isConnected.value
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Error banner
          Obx(() {
            final error = widget.chatController.connectionError.value;
            if (error.isEmpty) return const SizedBox.shrink();

            return Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.refresh),
                  //   onPressed: _initChat,
                  // ),
                ],
              ),
            );
          }),

          Expanded(
            child: Obx(() {
              if (widget.chatController.isLoading.value) {
                return const Center(child: CrmLoadingCircle());
              }

              final chatMessages =
                  widget.chatController.messages
                      .where(
                        (m) =>
                            (m.senderId == widget.userId) ||
                            (m.senderId == widget.receiverId),
                      )
                      .toList();

              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.all(10),
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  final isMe = message.senderId == widget.userId;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
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
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(isMe ? 12 : 0),
                          topRight: Radius.circular(isMe ? 0 : 12),
                        ),),

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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                formatTime(message.timestamp),
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
                                  color:
                                      message.status == MessageStatus.read
                                          ? Colors.blue[100]
                                          : Colors.white70,
                                ),
                              ],
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

          Obx(() {
            final isTyping =
                widget.chatController.typingStatus[widget.receiverId] ?? false;
            if (!isTyping) return const SizedBox.shrink();
            return const TypingIndicator();
          }),

          // Input
          CrmCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() {
                    if (selectedFile.value == null)
                      return const SizedBox.shrink();
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

                          // onChanged: (text) {
                          //   widget.chatController.sendTyping(
                          //     TypingEvent(
                          //       isTyping: text.isNotEmpty,
                          //       senderId: widget.userId,
                          //       receiverId: widget.receiverId,
                          //     ),
                          //   );
                          // },
                          onChanged: (text) {

                            // If user started typing, notify once
                            if (text.isNotEmpty) {
                              widget.chatController.sendTyping(
                                TypingEvent(
                                  isTyping: true,
                                  senderId: widget.userId,
                                  receiverId: widget.receiverId,
                                ),
                              );

                              // Reset the timer every keystroke
                              _typingTimer?.cancel();
                              _typingTimer = Timer(
                                const Duration(seconds: 2),
                                () {
                                  // Send stop typing after user is idle
                                  widget.chatController.sendTyping(
                                    TypingEvent(
                                      isTyping: false,
                                      senderId: widget.userId,
                                      receiverId: widget.receiverId,
                                    ),
                                  );
                                },
                              );
                            } else {
                              // User cleared input → immediately send stop typing
                              widget.chatController.sendTyping(
                                TypingEvent(
                                  isTyping: false,
                                  senderId: widget.userId,
                                  receiverId: widget.receiverId,
                                ),
                              );
                              _typingTimer?.cancel();
                            }
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
                        color: ColorRes.primary,
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

  String formatTime(DateTime timestamp) {
    // Always convert to local time for user-friendly display
    final localTime = timestamp.toLocal();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(localTime.year, localTime.month, localTime.day);

    final timeFormat = DateFormat('hh:mm a'); // 12-hour format (e.g. 08:15 PM)

    if (date == today) {
      return timeFormat.format(localTime);
    } else if (date == yesterday) {
      return 'Yesterday, ${timeFormat.format(localTime)}';
    } else if (localTime.year == now.year) {
      return DateFormat(
        'dd MMM, hh:mm a',
      ).format(localTime); // e.g. 14 Sep, 08:15 PM
    } else {
      return DateFormat(
        'dd MMM yyyy, hh:mm a',
      ).format(localTime); // e.g. 14 Sep 2024, 08:15 PM
    }
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
              topLeft: Radius.circular(0),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.2,
          ),

          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated dots
                AnimatedBuilder(
                  animation: _animation,
                  builder: (_, __) {
                    final dotCount = (_animation.value).floor() % 3 + 1;
                    final dots = List.generate(dotCount, (_) => "•").join(" ");
                    return Text(
                      dots,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
