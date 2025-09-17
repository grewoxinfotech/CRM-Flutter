// import 'dart:convert';
//
// /// Base chat event model (for WebSocket/event stream)
// class ChatEvent {
//   final String
//   type; // e.g. send_message, receive_message, typing, mark_messages_read, upload_chat_files
//   final dynamic data;
//
//   ChatEvent({required this.type, required this.data});
//
//   /// Parse event payload from socket (array format)
//   factory ChatEvent.fromJson(List<dynamic> json) {
//     final String type = json[0];
//     final Map<String, dynamic> payload = json[1];
//
//     switch (type) {
//       case "send_message":
//       case "receive_message":
//         return ChatEvent(
//           type: type,
//           data: ChatMessage.fromJson(payload['message'] ?? payload),
//         );
//       case "typing":
//         return ChatEvent(type: type, data: TypingEvent.fromJson(payload));
//       case "mark_messages_read":
//         return ChatEvent(type: type, data: ReadReceipt.fromJson(payload));
//       case "upload_chat_files":
//         return ChatEvent(type: type, data: UploadChatFiles.fromJson(payload));
//       default:
//         return ChatEvent(type: type, data: payload);
//     }
//   }
// }
//
// /// -------------------------
// /// Chat message (Text only)
// /// -------------------------
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   final String status; // sent, delivered, read
//   final DateTime? deliveredAt;
//   final DateTime? readAt;
//
//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     required this.status,
//     this.deliveredAt,
//     this.readAt,
//   });
//
//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       id: json['id'],
//       senderId: json['sender_id'],
//       receiverId: json['receiver_id'],
//       message: json['message'] ?? "",
//       timestamp: DateTime.parse(json['timestamp']),
//       status: json['status'],
//       deliveredAt:
//           json['delivered_at'] != null
//               ? DateTime.tryParse(json['delivered_at'])
//               : null,
//       readAt:
//           json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "message": message,
//       "timestamp": timestamp.toIso8601String(),
//       "status": status,
//       "delivered_at": deliveredAt?.toIso8601String(),
//       "read_at": readAt?.toIso8601String(),
//     };
//   }
// }
//
// /// -------------------------
// /// Typing event
// /// -------------------------
// class TypingEvent {
//   final String senderId;
//   final String receiverId;
//   final bool isTyping;
//
//   TypingEvent({
//     required this.senderId,
//     required this.receiverId,
//     required this.isTyping,
//   });
//
//   factory TypingEvent.fromJson(Map<String, dynamic> json) {
//     return TypingEvent(
//       senderId: json['sender_id'],
//       receiverId: json['receiver_id'],
//       isTyping: json['isTyping'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "isTyping": isTyping,
//     };
//   }
// }
//
// /// -------------------------
// /// Read receipt
// /// -------------------------
// class ReadReceipt {
//   final String senderId;
//   final String receiverId;
//
//   ReadReceipt({required this.senderId, required this.receiverId});
//
//   factory ReadReceipt.fromJson(Map<String, dynamic> json) {
//     return ReadReceipt(
//       senderId: json['sender_id'],
//       receiverId: json['receiver_id'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {"sender_id": senderId, "receiver_id": receiverId};
//   }
// }
//
// /// -------------------------
// /// File upload event
// /// -------------------------
// class UploadChatFiles {
//   final List<ChatFile> files;
//   final String senderId;
//   final String receiverId;
//   final String message; // optional caption
//
//   UploadChatFiles({
//     required this.files,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//   });
//
//   factory UploadChatFiles.fromJson(Map<String, dynamic> json) {
//     return UploadChatFiles(
//       files: (json['files'] as List).map((f) => ChatFile.fromJson(f)).toList(),
//       senderId: json['sender_id'],
//       receiverId: json['receiver_id'],
//       message: json['message'] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "files": files.map((e) => e.toJson()).toList(),
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "message": message,
//     };
//   }
// }
//
// class ChatFile {
//   final String name;
//   final String type;
//   final int size;
//   final String? data; // base64 string
//   final Map<String, dynamic>? fileMeta; // placeholder info
//
//   ChatFile({
//     required this.name,
//     required this.type,
//     required this.size,
//     this.data,
//     this.fileMeta,
//   });
//
//   factory ChatFile.fromJson(Map<String, dynamic> json) {
//     return ChatFile(
//       name: json['name'],
//       type: json['type'],
//       size: json['size'],
//       data: json['data'],
//       fileMeta: json['file'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "type": type,
//       "size": size,
//       "data": data,
//       "file": fileMeta,
//     };
//   }
// }

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import 'package:crm_flutter/app/care/constants/color_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:crm_flutter/app/widgets/input/crm_text_field.dart';
//
//
//
// class ChatFile {
//   final String name;
//   final String type;
//   final int size;
//   final String data; // base64 string
//
//   ChatFile({
//     required this.name,
//     required this.type,
//     required this.size,
//     required this.data,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "type": type,
//     "size": size,
//     "data": data,
//   };
// }
//
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String content;
//   final String type; // "text" or "file"
//   final DateTime timestamp;
//   final String status; // sent/delivered/read
//
//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.content,
//     required this.type,
//     required this.timestamp,
//     required this.status,
//   });
//
//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       id: json["id"] ?? "",
//       senderId: json["sender_id"] ?? "",
//       receiverId: json["receiver_id"] ?? "",
//       content: json["message"] ?? "",
//       type: json["type"] ?? "text",
//       timestamp: DateTime.tryParse(json["timestamp"] ?? "") ?? DateTime.now(),
//       status: json["status"] ?? "sent",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//     "message": content,
//     "type": type,
//     "timestamp": timestamp.toIso8601String(),
//     "status": status,
//   };
// }

// import 'dart:convert';
//
// /// -------------------------
// /// Enums
// /// -------------------------
// enum ChatEventType {
//   sendMessage,
//   receiveMessage,
//   typing,
//   markMessagesRead,
//   uploadChatFiles,
//   unknown,
// }
//
// extension ChatEventTypeX on ChatEventType {
//   String get value {
//     switch (this) {
//       case ChatEventType.sendMessage:
//         return "send_message";
//       case ChatEventType.receiveMessage:
//         return "receive_message";
//       case ChatEventType.typing:
//         return "typing";
//       case ChatEventType.markMessagesRead:
//         return "mark_messages_read";
//       case ChatEventType.uploadChatFiles:
//         return "upload_chat_files";
//       default:
//         return "unknown";
//     }
//   }
//
//   static ChatEventType fromString(String type) {
//     switch (type) {
//       case "send_message":
//         return ChatEventType.sendMessage;
//       case "receive_message":
//         return ChatEventType.receiveMessage;
//       case "typing":
//         return ChatEventType.typing;
//       case "mark_messages_read":
//         return ChatEventType.markMessagesRead;
//       case "upload_chat_files":
//         return ChatEventType.uploadChatFiles;
//       default:
//         return ChatEventType.unknown;
//     }
//   }
// }
//
// enum MessageStatus { sent, delivered, read }
//
// extension MessageStatusX on MessageStatus {
//   String get value {
//     switch (this) {
//       case MessageStatus.sent:
//         return "sent";
//       case MessageStatus.delivered:
//         return "delivered";
//       case MessageStatus.read:
//         return "read";
//     }
//   }
//
//   static MessageStatus fromString(String status) {
//     switch (status) {
//       case "delivered":
//         return MessageStatus.delivered;
//       case "read":
//         return MessageStatus.read;
//       default:
//         return MessageStatus.sent;
//     }
//   }
// }
//
// /// -------------------------
// /// Base chat event model
// /// -------------------------
// class ChatEvent {
//   final ChatEventType type;
//   final dynamic data;
//
//   ChatEvent({required this.type, required this.data});
//
//   factory ChatEvent.fromJson(List<dynamic> json) {
//     final String rawType = json.isNotEmpty ? json[0] as String : "unknown";
//     final dynamic payloadRaw = json.length > 1 ? json[1] : {};
//     final Map<String, dynamic> payload =
//         payloadRaw is Map<String, dynamic> ? payloadRaw : {};
//
//     final eventType = ChatEventTypeX.fromString(rawType);
//
//     switch (eventType) {
//       case ChatEventType.sendMessage:
//       case ChatEventType.receiveMessage:
//         return ChatEvent(
//           type: eventType,
//           data: ChatMessage.fromJson(payload['message'] ?? payload),
//         );
//       case ChatEventType.typing:
//         return ChatEvent(type: eventType, data: TypingEvent.fromJson(payload));
//       case ChatEventType.markMessagesRead:
//         return ChatEvent(type: eventType, data: ReadReceipt.fromJson(payload));
//       case ChatEventType.uploadChatFiles:
//         return ChatEvent(
//           type: eventType,
//           data: UploadChatFiles.fromJson(payload),
//         );
//       default:
//         return ChatEvent(type: eventType, data: payload);
//     }
//   }
// }
//
// /// -------------------------
// /// Chat message
// /// -------------------------
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   final MessageStatus status;
//   final DateTime? deliveredAt;
//   final DateTime? readAt;
//
//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     required this.status,
//     this.deliveredAt,
//     this.readAt,
//   });
//
//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       id: json['id'] ?? '',
//       senderId: json['sender_id'] ?? json['senderId'] ?? '',
//       receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//       message: json['message'] ?? "",
//       timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
//       status: MessageStatusX.fromString(json['status'] ?? 'sent'),
//       deliveredAt:
//           json['delivered_at'] != null
//               ? DateTime.tryParse(json['delivered_at'])
//               : null,
//       readAt:
//           json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "message": message,
//       "timestamp": timestamp.toIso8601String(),
//       "status": status.value,
//       "delivered_at": deliveredAt?.toIso8601String(),
//       "read_at": readAt?.toIso8601String(),
//     };
//   }
// }
//
// /// -------------------------
// /// Typing event
// /// -------------------------
// class TypingEvent {
//   final String senderId;
//   final String receiverId;
//   final bool isTyping;
//
//   TypingEvent({
//     required this.senderId,
//     required this.receiverId,
//     required this.isTyping,
//   });
//
//   factory TypingEvent.fromJson(Map<String, dynamic> json) {
//     return TypingEvent(
//       senderId: json['sender_id'] ?? json['senderId'] ?? '',
//       receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//       isTyping: json['isTyping'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "isTyping": isTyping,
//     };
//   }
// }
//
// /// -------------------------
// /// Read receipt
// /// -------------------------
// class ReadReceipt {
//   final String senderId;
//   final String receiverId;
//
//   ReadReceipt({required this.senderId, required this.receiverId});
//
//   factory ReadReceipt.fromJson(Map<String, dynamic> json) {
//     return ReadReceipt(
//       senderId: json['sender_id'] ?? json['senderId'] ?? '',
//       receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {"sender_id": senderId, "receiver_id": receiverId};
//   }
// }
//
// /// -------------------------
// /// File upload event
// /// -------------------------
// class UploadChatFiles {
//   final List<ChatFile> files;
//   final String senderId;
//   final String receiverId;
//   final String message; // optional caption
//
//   UploadChatFiles({
//     required this.files,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//   });
//
//   factory UploadChatFiles.fromJson(Map<String, dynamic> json) {
//     return UploadChatFiles(
//       files:
//           (json['files'] as List? ?? [])
//               .map((f) => ChatFile.fromJson(f))
//               .toList(),
//       senderId: json['sender_id'] ?? json['senderId'] ?? '',
//       receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//       message: json['message'] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "files": files.map((e) => e.toJson()).toList(),
//       "sender_id": senderId,
//       "receiver_id": receiverId,
//       "message": message,
//     };
//   }
// }
//
// class ChatFile {
//   final String name;
//   final String type;
//   final int size;
//   final String? data; // base64 string
//   final Map<String, dynamic>? fileMeta; // placeholder info
//
//   ChatFile({
//     required this.name,
//     required this.type,
//     required this.size,
//     this.data,
//     this.fileMeta,
//   });
//
//   factory ChatFile.fromJson(Map<String, dynamic> json) {
//     return ChatFile(
//       name: json['name'] ?? '',
//       type: json['type'] ?? '',
//       size: json['size'] ?? 0,
//       data: json['data'],
//       fileMeta: json['file'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "type": type,
//       "size": size,
//       "data": data,
//       "file": fileMeta,
//     };
//   }
// }

// import 'dart:convert';
//
// /// -------------------------
// /// Enums
// /// -------------------------
// enum ChatEventType {
//   sendMessage,
//   receiveMessage,
//   typing,
//   markMessagesRead,
//   uploadChatFiles,
//   unknown,
// }
//
// extension ChatEventTypeX on ChatEventType {
//   String get value {
//     switch (this) {
//       case ChatEventType.sendMessage:
//         return "send_message";
//       case ChatEventType.receiveMessage:
//         return "receive_message";
//       case ChatEventType.typing:
//         return "typing";
//       case ChatEventType.markMessagesRead:
//         return "mark_messages_read";
//       case ChatEventType.uploadChatFiles:
//         return "upload_chat_files";
//       default:
//         return "unknown";
//     }
//   }
//
//   static ChatEventType fromString(String type) {
//     switch (type) {
//       case "send_message":
//         return ChatEventType.sendMessage;
//       case "receive_message":
//         return ChatEventType.receiveMessage;
//       case "typing":
//         return ChatEventType.typing;
//       case "mark_messages_read":
//         return ChatEventType.markMessagesRead;
//       case "upload_chat_files":
//         return ChatEventType.uploadChatFiles;
//       default:
//         return ChatEventType.unknown;
//     }
//   }
// }
//
// enum MessageStatus { sent, delivered, read }
//
// extension MessageStatusX on MessageStatus {
//   String get value {
//     switch (this) {
//       case MessageStatus.sent:
//         return "sent";
//       case MessageStatus.delivered:
//         return "delivered";
//       case MessageStatus.read:
//         return "read";
//     }
//   }
//
//   static MessageStatus fromString(String status) {
//     switch (status) {
//       case "delivered":
//         return MessageStatus.delivered;
//       case "read":
//         return MessageStatus.read;
//       default:
//         return MessageStatus.sent;
//     }
//   }
// }
//
// /// -------------------------
// /// Base chat event model
// /// -------------------------
// class ChatEvent {
//   final ChatEventType type;
//   final dynamic data;
//
//   ChatEvent({required this.type, required this.data});
//
//   factory ChatEvent.fromJson(List<dynamic> json) {
//     final rawType = json.isNotEmpty ? json[0] as String : "unknown";
//     final payloadRaw = json.length > 1 ? json[1] : {};
//     final payload = payloadRaw;
//
//     final eventType = ChatEventTypeX.fromString(rawType);
//
//     switch (eventType) {
//       case ChatEventType.sendMessage:
//       case ChatEventType.receiveMessage:
//         return ChatEvent(
//           type: eventType,
//           data: ChatMessage.fromJson(payload['message'] ?? payload),
//         );
//       case ChatEventType.typing:
//         return ChatEvent(type: eventType, data: TypingEvent.fromJson(payload));
//       case ChatEventType.markMessagesRead:
//         return ChatEvent(type: eventType, data: ReadReceipt.fromJson(payload));
//       case ChatEventType.uploadChatFiles:
//         return ChatEvent(
//           type: eventType,
//           data: UploadChatFiles.fromJson(payload),
//         );
//       default:
//         return ChatEvent(type: eventType, data: payload);
//     }
//   }
// }
//
// /// -------------------------
// /// Chat message
// /// -------------------------
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   final MessageStatus status;
//   final DateTime? deliveredAt;
//   final DateTime? readAt;
//
//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     required this.status,
//     this.deliveredAt,
//     this.readAt,
//   });
//
//   factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
//     id: json['id'] ?? '',
//     senderId: json['sender_id'] ?? json['senderId'] ?? '',
//     receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//     message: json['message'] ?? '',
//     timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
//     status: MessageStatusX.fromString(json['status'] ?? 'sent'),
//     deliveredAt:
//         json['delivered_at'] != null
//             ? DateTime.tryParse(json['delivered_at'])
//             : null,
//     readAt: json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//     "message": message,
//     "timestamp": timestamp.toIso8601String(),
//     "status": status.value,
//     "delivered_at": deliveredAt?.toIso8601String(),
//     "read_at": readAt?.toIso8601String(),
//   };
// }
//
// /// -------------------------
// /// Typing event
// /// -------------------------
// class TypingEvent {
//   final String senderId;
//   final String receiverId;
//   final bool isTyping;
//
//   TypingEvent({
//     required this.senderId,
//     required this.receiverId,
//     required this.isTyping,
//   });
//
//   factory TypingEvent.fromJson(Map<String, dynamic> json) => TypingEvent(
//     senderId: json['sender_id'] ?? json['senderId'] ?? '',
//     receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//     isTyping: json['isTyping'] ?? false,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//     "isTyping": isTyping,
//   };
// }
//
// /// -------------------------
// /// Read receipt
// /// -------------------------
// class ReadReceipt {
//   final String senderId;
//   final String receiverId;
//
//   ReadReceipt({required this.senderId, required this.receiverId});
//
//   factory ReadReceipt.fromJson(Map<String, dynamic> json) => ReadReceipt(
//     senderId: json['sender_id'] ?? json['senderId'] ?? '',
//     receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//   };
// }
//
// /// -------------------------
// /// File upload event
// /// -------------------------
// class UploadChatFiles {
//   final List<ChatFile> files;
//   final String senderId;
//   final String receiverId;
//   final String message; // optional caption
//
//   UploadChatFiles({
//     required this.files,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//   });
//
//   factory UploadChatFiles.fromJson(Map<String, dynamic> json) =>
//       UploadChatFiles(
//         files:
//             (json['files'] as List? ?? [])
//                 .map((f) => ChatFile.fromJson(f))
//                 .toList(),
//         senderId: json['sender_id'] ?? json['senderId'] ?? '',
//         receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//         message: json['message'] ?? '',
//       );
//
//   Map<String, dynamic> toJson() => {
//     "files": files.map((f) => f.toJson()).toList(),
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//     "message": message,
//   };
// }
//
// class ChatFile {
//   final String name;
//   final String type;
//   final int size;
//   final String? data; // base64 string
//   final Map<String, dynamic>? fileMeta; // optional metadata
//
//   ChatFile({
//     required this.name,
//     required this.type,
//     required this.size,
//     this.data,
//     this.fileMeta,
//   });
//
//   factory ChatFile.fromJson(Map<String, dynamic> json) => ChatFile(
//     name: json['name'] ?? '',
//     type: json['type'] ?? '',
//     size: json['size'] ?? 0,
//     data: json['data'],
//     fileMeta: json['file'],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "type": type,
//     "size": size,
//     "data": data,
//     "file": fileMeta,
//   };
// }

import 'dart:convert';

/// -------------------------
/// Enums
/// -------------------------
enum ChatEventType {
  sendMessage,
  receiveMessage,
  typing,
  getCoversations,
  markMessagesRead,
  uploadChatFiles,
  unknown,
}

extension ChatEventTypeX on ChatEventType {
  String get value {
    switch (this) {
      case ChatEventType.sendMessage:
        return "send_message";
      case ChatEventType.receiveMessage:
        return "receive_message";
      case ChatEventType.getCoversations:
        return "get_conversations";
      case ChatEventType.typing:
        return "typing";
      case ChatEventType.markMessagesRead:
        return "mark_messages_read";
      case ChatEventType.uploadChatFiles:
        return "upload_chat_files";
      default:
        return "unknown";
    }
  }

  static ChatEventType fromString(String type) {
    switch (type) {
      case "send_message":
        return ChatEventType.sendMessage;
      case "receive_message":
        return ChatEventType.receiveMessage;
      case "typing":
        return ChatEventType.typing;
      case "mark_messages_read":
        return ChatEventType.markMessagesRead;
      case "upload_chat_files":
        return ChatEventType.uploadChatFiles;
      default:
        return ChatEventType.unknown;
    }
  }
}

enum MessageStatus { sent, delivered, read }

extension MessageStatusX on MessageStatus {
  String get value {
    switch (this) {
      case MessageStatus.sent:
        return "sent";
      case MessageStatus.delivered:
        return "delivered";
      case MessageStatus.read:
        return "read";
    }
  }

  static MessageStatus fromString(String status) {
    switch (status) {
      case "delivered":
        return MessageStatus.delivered;
      case "read":
        return MessageStatus.read;
      default:
        return MessageStatus.sent;
    }
  }
}

/// -------------------------
/// Base chat event model
/// -------------------------
class ChatEvent {
  final ChatEventType type;
  final dynamic data;

  ChatEvent({required this.type, required this.data});

  factory ChatEvent.fromJson(List<dynamic> json) {
    final rawType = json.isNotEmpty ? json[0] as String : "unknown";
    final payloadRaw = json.length > 1 ? json[1] : {};
    final payload =
        payloadRaw is Map<String, dynamic> ? payloadRaw : <String, dynamic>{};

    final eventType = ChatEventTypeX.fromString(rawType);

    switch (eventType) {
      case ChatEventType.sendMessage:
      case ChatEventType.receiveMessage:
        return ChatEvent(
          type: eventType,
          data: ChatMessage.fromJson(payload['message'] ?? payload),
        );
      case ChatEventType.typing:
        return ChatEvent(type: eventType, data: TypingEvent.fromJson(payload));
      case ChatEventType.markMessagesRead:
        return ChatEvent(type: eventType, data: ReadReceipt.fromJson(payload));
      case ChatEventType.uploadChatFiles:
        return ChatEvent(
          type: eventType,
          data: UploadChatFilesRequest.fromJson(payload),
        );
      default:
        return ChatEvent(type: eventType, data: payload);
    }
  }
}

/// -------------------------
/// Chat message
/// -------------------------
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final MessageStatus status;
  final DateTime? deliveredAt;
  final DateTime? readAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.status,
    this.deliveredAt,
    this.readAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] ?? '',
    senderId: json['sender_id'] ?? json['senderId'] ?? '',
    receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
    message: json['message'] ?? '',
    timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    status: MessageStatusX.fromString(json['status'] ?? 'sent'),
    deliveredAt:
        json['delivered_at'] != null
            ? DateTime.tryParse(json['delivered_at'])
            : null,
    readAt: json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "timestamp": timestamp.toIso8601String(),
    "status": status.value,
    "delivered_at": deliveredAt?.toIso8601String(),
    "read_at": readAt?.toIso8601String(),
  };

  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? message,
    DateTime? timestamp,
    MessageStatus? status,
    DateTime? deliveredAt,
    DateTime? readAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
    );
  }

}

/// -------------------------
/// Typing event
/// -------------------------
class TypingEvent {
  final String senderId;
  final String receiverId;
  final bool isTyping;

  TypingEvent({
    required this.senderId,
    required this.receiverId,
    required this.isTyping,
  });

  factory TypingEvent.fromJson(Map<String, dynamic> json) => TypingEvent(
    senderId: json['sender_id'] ?? json['senderId'] ?? '',
    receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
    isTyping: json['isTyping'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "receiver_id": receiverId,
    "isTyping": isTyping,
  };
}

/// -------------------------
/// Read receipt
/// -------------------------
class ReadReceipt {
  final String senderId;
  final String receiverId;

  ReadReceipt({required this.senderId, required this.receiverId});

  factory ReadReceipt.fromJson(Map<String, dynamic> json) => ReadReceipt(
    senderId: json['sender_id'] ?? json['senderId'] ?? '',
    receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "receiver_id": receiverId,
  };
}

/// -------------------------
/// File upload event
/// -------------------------
// class UploadChatFiles {
//   final List<ChatFile> files;
//   final String senderId;
//   final String receiverId;
//   final String message; // optional caption
//
//   UploadChatFiles({
//     required this.files,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//   });
//
//   factory UploadChatFiles.fromJson(Map<String, dynamic> json) =>
//       UploadChatFiles(
//         files:
//             (json['files'] as List? ?? [])
//                 .map((f) => ChatFile.fromJson(f))
//                 .toList(),
//         senderId: json['sender_id'] ?? json['senderId'] ?? '',
//         receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
//         message: json['message'] ?? '',
//       );
//
//   Map<String, dynamic> toJson() => {
//     "files": files.map((f) => f.toJson()).toList(),
//     "sender_id": senderId,
//     "receiver_id": receiverId,
//     "message": message,
//   };
// }
//
// class ChatFile {
//   final String name;
//   final String type;
//   final int size;
//   final String? data; // base64 string
//   final Map<String, dynamic>? fileMeta; // optional metadata
//
//   ChatFile({
//     required this.name,
//     required this.type,
//     required this.size,
//     this.data,
//     this.fileMeta,
//   });
//
//   factory ChatFile.fromJson(Map<String, dynamic> json) => ChatFile(
//     name: json['name'] ?? '',
//     type: json['type'] ?? '',
//     size: json['size'] ?? 0,
//     data: json['data'],
//     fileMeta: json['file'],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "type": type,
//     "size": size,
//     "data": data,
//     "file": fileMeta,
//   };
// }

class UploadChatFilesRequest {
  final List<ChatFile> files;
  final String senderId;
  final String receiverId;
  final String message;

  UploadChatFilesRequest({
    required this.files,
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  factory UploadChatFilesRequest.fromJson(Map<String, dynamic> json) {
    return UploadChatFilesRequest(
      files: (json['files'] as List)
          .map((e) => ChatFile.fromJson(e))
          .toList(),
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    "files": files.map((f) => f.toJson()).toList(),
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
  };
}

class ChatFile {
  final FileMeta file;
  final String name;
  final String type;
  final int size;
  final String? data; // optional because sometimes backend might not send full data

  ChatFile({
    required this.file,
    required this.name,
    required this.type,
    required this.size,
    this.data,
  });

  factory ChatFile.fromJson(Map<String, dynamic> json) {
    return ChatFile(
      file: FileMeta.fromJson(json['file']),
      name: json['name'],
      type: json['type'],
      size: json['size'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    "file": file.toJson(),
    "name": name,
    "type": type,
    "size": size,
    if (data != null) "data": data,
  };
}

class FileMeta {
  final bool placeholder;
  final int num;

  FileMeta({
    required this.placeholder,
    required this.num,
  });

  factory FileMeta.fromJson(Map<String, dynamic> json) {
    return FileMeta(
      placeholder: json['_placeholder'],
      num: json['num'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_placeholder": placeholder,
    "num": num,
  };
}
