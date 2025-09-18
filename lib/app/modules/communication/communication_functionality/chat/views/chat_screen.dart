// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:crm_flutter/app/care/constants/color_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../../data/network/communication/chat/chat_model.dart';
// import '../../../../../widgets/common/display/crm_card.dart';
// import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
// import '../controllers/chat_controller.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String userId;
//   final String receiverId;
//   final String receiverName;
//   final ChatController chatController;
//
//   const ChatScreen({
//     Key? key,
//     required this.userId,
//     required this.receiverId,
//     required this.chatController,
//     required this.receiverName,
//   }) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   bool _isEmojiVisible = false;
//   final FocusNode _focusNode = FocusNode();
//   Timer? _typingTimer;
//   // final ChatController widget.chatController = Get.put(ChatController());
//   final TextEditingController messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   Rxn<File> selectedFile = Rxn<File>();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void _initChat() {
//     widget.chatController.connect(
//       'https://api.raiser.in',
//       query: {'userId': widget.userId},
//       userId: widget.userId,
//     );
//   }
//
//   void _toggleEmojiKeyboard() {
//     if (_isEmojiVisible) {
//       // open system keyboard
//       FocusScope.of(context).requestFocus(_focusNode);
//     } else {
//       // close system keyboard
//       FocusScope.of(context).unfocus();
//     }
//     setState(() {
//       _isEmojiVisible = !_isEmojiVisible;
//     });
//   }
//
//   @override
//   void dispose() {
//     messageController.dispose();
//     _scrollController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   Future<void> selectFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.any,
//         allowMultiple: false,
//         withData: true,
//       );
//
//       if (result != null && result.files.single.path != null) {
//         File file = File(result.files.single.path!);
//         // Check file size (limit to 10MB)
//         if (await file.length() > 10 * 1024 * 1024) {
//           Get.snackbar(
//             'Error',
//             'File size must be less than 10MB',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//           return;
//         }
//         selectedFile.value = file;
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to select file: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   Future<void> sendMessage() async {
//     final messageText = messageController.text.trim();
//     final file = selectedFile.value;
//
//     if (messageText.isEmpty && file == null) return;
//
//     try {
//       // Handle file upload first if present
//       if (file != null) {
//         final name = file.path.split('/').last;
//         final extension = name.contains('.') ? name.split('.').last : 'unknown';
//         final type = "image/$extension"; // or use lookupMimeType(file.path)
//         final size = await file.length();
//         final bytes = await file.readAsBytes();
//
//         final chatFile = ChatFile(
//           file: FileMeta(placeholder: true, num: 0),
//           name: name,
//           type: type,
//           size: size,
//           data: base64Encode(bytes),
//         );
//
//         final uploadRequest = UploadChatFilesRequest(
//           files: [chatFile], // must be a list
//           senderId: widget.userId,
//           receiverId: widget.receiverId,
//           message: messageText.isEmpty ? "" : messageText,
//         );
//
//         widget.chatController.sendFileChat(uploadRequest);
//         selectedFile.value = null;
//       }
//
//       // Send text message if present
//       if (messageText.isNotEmpty) {
//         final msg = ChatMessage(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           receiverId: widget.receiverId,
//           status: MessageStatus.sent,
//           senderId: widget.userId,
//           message: messageText,
//           conversationId: widget.receiverId,
//           timestamp: DateTime.now(),
//         );
//
//         widget.chatController.sendMessage(msg);
//         messageController.clear();
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to send message: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorRes.white,
//         foregroundColor: ColorRes.primary,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 18,
//               child: Text(
//                 widget.receiverName.isNotEmpty
//                     ? widget.receiverName[0].toUpperCase()
//                     : '?',
//                 style: TextStyle(color: ColorRes.white),
//               ),
//             ),
//             SizedBox(width: AppSpacing.medium),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   widget.receiverName,
//                   style: TextStyle(color: ColorRes.primary),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: AppSpacing.xSmall),
//                 Obx(() {
//                   final isTyping =
//                       widget.chatController.typingStatus[widget.receiverId] ?? false;
//
//                   if (isTyping) {
//                     return Text(
//                       'typing...',
//                       style: TextStyle(
//                         color: ColorRes.grey,
//                         fontSize: 12,
//                       ),
//                     );
//                   }
//
//                   final status = widget.chatController.userStatus[widget.receiverId];
//                   if (status == null) {
//                     return SizedBox.shrink();
//                   }
//
//                   final isOnline = status['isOnline'] ?? false;
//                   final lastSeen = status['lastSeen'] ?? '';
//
//                   return Text(
//                     isOnline
//                         ? "Online"
//                         : "Last seen: ${formatTime(DateTime.tryParse(lastSeen)!)}",
//                     style: TextStyle(
//                       color: isOnline ? Colors.green : ColorRes.grey,
//                       fontSize: 12,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // Error banner
//           Obx(() {
//             final error = widget.chatController.connectionError.value;
//             if (error.isEmpty) return const SizedBox.shrink();
//
//             return Container(
//               color: Colors.red[100],
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   const Icon(Icons.error_outline, color: Colors.red),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       error,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.refresh),
//                     onPressed: _initChat,
//                   ),
//                 ],
//               ),
//             );
//           }),
//
//           Expanded(
//             child: Obx(() {
//               if (widget.chatController.isLoading.value) {
//                 return const Center(child: CrmLoadingCircle());
//               }
//
//               final chatMessages =
//                   widget.chatController.messages
//                       .where((m) => m.conversationId == widget.receiverId)
//                       .toList();
//
//               if (chatMessages.any(
//                 (m) =>
//                     m.conversationId == widget.receiverId &&
//                     m.status != MessageStatus.read,
//               )) {
//                 print("Marking message as read");
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   widget.chatController.markMessageAsRead(
//                     widget.receiverId,
//                     widget.userId,
//                   );
//                 });
//               }
//
//               return ListView.builder(
//                 controller: _scrollController,
//                 reverse: true,
//                 padding: const EdgeInsets.all(10),
//                 itemCount: chatMessages.length,
//                 itemBuilder: (context, index) {
//                   final message = chatMessages[index];
//                   final isMe = message.senderId == widget.userId;
//
//                   return Align(
//                     alignment:
//                         isMe ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       constraints: BoxConstraints(
//                         maxWidth: MediaQuery.of(context).size.width * 0.75,
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8,
//                         horizontal: 12,
//                       ),
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       decoration: BoxDecoration(
//                         color: isMe ? ColorRes.primary : Colors.grey[300],
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(12),
//                           bottomRight: Radius.circular(12),
//                           topLeft: Radius.circular(isMe ? 12 : 0),
//                           topRight: Radius.circular(isMe ? 0 : 12),
//                         ),
//                       ),
//
//                       child: Column(
//                         crossAxisAlignment:
//                             isMe
//                                 ? CrossAxisAlignment.end
//                                 : CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             message.message,
//                             style: TextStyle(
//                               color: isMe ? Colors.white : Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 formatTime(message.timestamp),
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   color: isMe ? Colors.white70 : Colors.black45,
//                                 ),
//                               ),
//                               if (isMe) ...[
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   message.status == MessageStatus.sent
//                                       ? Icons.done
//                                       : Icons.done_all,
//                                   size: 14,
//                                   color:
//                                       message.status == MessageStatus.read
//                                           ? Colors
//                                               .blue[300] // read → blue double tick
//                                           : Colors
//                                               .white70, // sent/delivered → grey/white
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//
//           Obx(() {
//             final isTyping =
//                 widget.chatController.typingStatus[widget.receiverId] ?? false;
//             if (!isTyping) return const SizedBox.shrink();
//             return const TypingIndicator();
//           }),
//
//           // Input
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Obx(() {
//                     if (selectedFile.value == null)
//                       return const SizedBox.shrink();
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.attach_file, size: 16),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               selectedFile.value!.path.split('/').last,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.close, size: 16),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(),
//                             onPressed: () => selectedFile.value = null,
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: messageController,
//                           maxLines: null,
//                           decoration: InputDecoration(
//                             hintText: 'Type a message...',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 8,
//                             ),
//                             prefixIcon: IconButton(
//                               icon: Icon(
//                                 _isEmojiVisible
//                                     ? Icons.keyboard
//                                     : Icons.emoji_emotions_outlined,
//                               ),
//                               onPressed: _toggleEmojiKeyboard,
//                             ),
//                           ),
//                           onChanged: (text) {
//                             // If user started typing, notify once
//                             if (text.isNotEmpty) {
//                               widget.chatController.sendTyping(
//                                 TypingEvent(
//                                   isTyping: true,
//                                   senderId: widget.userId,
//                                   receiverId: widget.receiverId,
//                                 ),
//                               );
//
//                               // Reset the timer every keystroke
//                               _typingTimer?.cancel();
//                               _typingTimer = Timer(
//                                 const Duration(seconds: 2),
//                                 () {
//                                   // Send stop typing after user is idle
//                                   widget.chatController.sendTyping(
//                                     TypingEvent(
//                                       isTyping: false,
//                                       senderId: widget.userId,
//                                       receiverId: widget.receiverId,
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else {
//                               // User cleared input → immediately send stop typing
//                               widget.chatController.sendTyping(
//                                 TypingEvent(
//                                   isTyping: false,
//                                   senderId: widget.userId,
//                                   receiverId: widget.receiverId,
//                                 ),
//                               );
//                               _typingTimer?.cancel();
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       IconButton(
//                         icon: const Icon(Icons.attach_file),
//                         onPressed: selectFile,
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.send),
//                         color: ColorRes.primary,
//                         onPressed: sendMessage,
//                       ),
//                     ],
//                   ),
//                   Offstage(
//                     offstage: !_isEmojiVisible,
//                     child: SizedBox(
//                       height: 250,
//                       child: EmojiPicker(
//                         textEditingController: messageController,
//                         onEmojiSelected: (Category? category, Emoji emoji) {
//                           messageController.selection = TextSelection.fromPosition(
//                             TextPosition(offset: messageController.text.length),
//                           );
//                         },
//                         config: Config(
//                           height: 250,
//                           emojiViewConfig: const EmojiViewConfig(
//                             emojiSizeMax: 28,
//                           ),
//                           // important for mobile: enables system emojis instead of blank boxes
//                           checkPlatformCompatibility: true,
//                         ),
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String formatTime(DateTime timestamp) {
//     // Always convert to local time for user-friendly display
//     final localTime = timestamp.toLocal();
//
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final date = DateTime(localTime.year, localTime.month, localTime.day);
//
//     final timeFormat = DateFormat('hh:mm a'); // 12-hour format (e.g. 08:15 PM)
//
//     if (date == today) {
//       return timeFormat.format(localTime);
//     } else if (date == yesterday) {
//       return 'Yesterday, ${timeFormat.format(localTime)}';
//     } else if (localTime.year == now.year) {
//       return DateFormat(
//         'dd MMM, hh:mm a',
//       ).format(localTime); // e.g. 14 Sep, 08:15 PM
//     } else {
//       return DateFormat(
//         'dd MMM yyyy, hh:mm a',
//       ).format(localTime); // e.g. 14 Sep 2024, 08:15 PM
//     }
//   }
// }
//
// class TypingIndicator extends StatefulWidget {
//   const TypingIndicator({super.key});
//
//   @override
//   State<TypingIndicator> createState() => _TypingIndicatorState();
// }
//
// class _TypingIndicatorState extends State<TypingIndicator>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat();
//     _animation = Tween<double>(begin: 0, end: 3).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//           margin: const EdgeInsets.only(bottom: 6),
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(12),
//               bottomRight: Radius.circular(12),
//               topRight: Radius.circular(12),
//               topLeft: Radius.circular(0),
//             ),
//           ),
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.2,
//           ),
//
//           child: Center(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Animated dots
//                 AnimatedBuilder(
//                   animation: _animation,
//                   builder: (_, __) {
//                     final dotCount = (_animation.value).floor() % 3 + 1;
//                     final dots = List.generate(dotCount, (_) => "•").join(" ");
//                     return Text(
//                       dots,
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/network/communication/chat/chat_model.dart';
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
  bool _isEmojiVisible = false;
  final FocusNode _focusNode = FocusNode();
  Timer? _typingTimer;
  final TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  Rxn<File> selectedFile = Rxn<File>();

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _initChat() {
    widget.chatController.connect(
      'https://api.raiser.in',
      query: {'userId': widget.userId},
      userId: widget.userId,
    );
  }

  void _toggleEmojiKeyboard() {
    if (_isEmojiVisible) {
      // Closing emoji picker → open system keyboard
      FocusScope.of(context).requestFocus(_focusNode);
    } else {
      // Opening emoji picker → close system keyboard
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    }

    setState(() {
      _isEmojiVisible = !_isEmojiVisible;
    });
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

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    final file = selectedFile.value;

    if (messageText.isEmpty && file == null) return;

    try {
      if (file != null) {
        final name = file.path.split('/').last;
        final extension = name.contains('.') ? name.split('.').last : 'unknown';
        final type = "image/$extension";
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
          files: [chatFile],
          senderId: widget.userId,
          receiverId: widget.receiverId,
          message: messageText.isEmpty ? "" : messageText,
        );

        widget.chatController.sendFileChat(uploadRequest);
        selectedFile.value = null;
      }

      if (messageText.isNotEmpty) {
        final msg = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          receiverId: widget.receiverId,
          status: MessageStatus.sent,
          senderId: widget.userId,
          message: messageText,
          conversationId: widget.receiverId,
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
        backgroundColor: Colors.white,
        elevation: 2,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueAccent.shade200,
              child: Text(
                widget.receiverName.isNotEmpty
                    ? widget.receiverName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Obx(() {
                  final isTyping = widget.chatController.typingStatus[widget.receiverId] ?? false;
                  if (isTyping) {
                    return const Text(
                      'typing...',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  }
                  final status = widget.chatController.userStatus[widget.receiverId];
                  if (status == null) return const SizedBox.shrink();
                  final isOnline = status['isOnline'] ?? false;
                  final lastSeen = status['lastSeen'] ?? '';
                  return Text(
                    isOnline ? "Online" : "Last seen: ${formatTime(DateTime.tryParse(lastSeen)!)}",
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 12,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
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
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _initChat,
                  ),
                ],
              ),
            );
          }),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFe0f7fa), // soft cyan
                    Color(0xFFf1f8e9), // soft green
                    Color(0xFFfffde7), // light yellow
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: Obx(() {
                if (widget.chatController.isLoading.value) {
                  return const Center(child: CrmLoadingCircle());
                }

                final chatMessages = widget.chatController.messages
                    .where((m) => m.conversationId == widget.receiverId)
                    .toList();

                if (chatMessages.any(
                      (m) => m.conversationId == widget.receiverId && m.status != MessageStatus.read,
                )) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.chatController.markMessageAsRead(
                      widget.receiverId,
                      widget.userId,
                    );
                  });
                }

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
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          gradient: isMe
                              ? LinearGradient(
                            colors: [ColorRes.primary, Colors.blueAccent.shade200],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : LinearGradient(
                            colors: [Colors.grey.shade200, Colors.grey.shade100],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(12),
                            bottomRight: const Radius.circular(12),
                            topLeft: Radius.circular(isMe ? 12 : 0),
                            topRight: Radius.circular(isMe ? 0 : 12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87,
                                fontSize: 14,
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
                                    message.status == MessageStatus.sent
                                        ? Icons.done
                                        : Icons.done_all,
                                    size: 14,
                                    color: message.status == MessageStatus.read
                                        ? Colors.blue[300]
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
          ),


          Obx(() {
            final isTyping = widget.chatController.typingStatus[widget.receiverId] ?? false;
            if (!isTyping) return const SizedBox.shrink();
            return const TypingIndicator();
          }),

          // Input
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() {
                    if (selectedFile.value == null) return const SizedBox.shrink();
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.attach_file, size: 16, color: Colors.blueGrey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedFile.value!.path.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => selectedFile.value = null,
                            child: const Icon(Icons.close, size: 16, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    );
                  }),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(
                                _isEmojiVisible ? Icons.keyboard : Icons.emoji_emotions_outlined,
                                color: Colors.grey[600],
                              ),
                              onPressed: _toggleEmojiKeyboard,
                            ),
                          ),
                          onChanged: (text) {
                            if (text.isNotEmpty) {
                              widget.chatController.sendTyping(
                                TypingEvent(
                                  isTyping: true,
                                  senderId: widget.userId,
                                  receiverId: widget.receiverId,
                                ),
                              );

                              _typingTimer?.cancel();
                              _typingTimer = Timer(
                                const Duration(seconds: 2),
                                    () {
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
                      InkWell(
                        onTap: sendMessage,
                        borderRadius: BorderRadius.circular(30),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: ColorRes.primary,
                          child: Center(child: const Icon(Icons.send_rounded, color: Colors.white,size: 20,)),
                        ),
                      ),
                    ],
                  ),
                  Offstage(
                    offstage: !_isEmojiVisible,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: messageController,
                        onEmojiSelected: (Category? category, Emoji emoji) {
                          messageController.selection = TextSelection.fromPosition(
                            TextPosition(offset: messageController.text.length),
                          );
                        },
                        config: Config(
                          height: 250,
                          emojiViewConfig: const EmojiViewConfig(
                            emojiSizeMax: 28,
                          ),
                          checkPlatformCompatibility: true,
                        ),
                      ),
                    ),
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
    final localTime = timestamp.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(localTime.year, localTime.month, localTime.day);

    final timeFormat = DateFormat('hh:mm a');

    if (date == today) {
      return timeFormat.format(localTime);
    } else if (date == yesterday) {
      return 'Yesterday, ${timeFormat.format(localTime)}';
    } else if (localTime.year == now.year) {
      return DateFormat('dd MMM, hh:mm a').format(localTime);
    } else {
      return DateFormat('dd MMM yyyy, hh:mm a').format(localTime);
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
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedBuilder(
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
        ),
      ),
    );
  }
}
