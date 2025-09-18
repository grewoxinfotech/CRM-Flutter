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

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String? conversationId; // 🔑 NEW
  final String message;
  final DateTime timestamp;
  final MessageStatus status;
  final DateTime? deliveredAt;
  final DateTime? readAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.conversationId, // 🔑 NEW
    required this.message,
    required this.timestamp,
    required this.status,
    this.deliveredAt,
    this.readAt,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic> json, {
    required String conversationId,
  }) {
    return ChatMessage(
      id: json['id'] ?? '',
      senderId: json['sender_id'] ?? json['senderId'] ?? '',
      receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
      conversationId: conversationId, // inject from outside
      message: json['message'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      status: MessageStatusX.fromString(json['status'] ?? 'sent'),
      deliveredAt:
          json['delivered_at'] != null
              ? DateTime.tryParse(json['delivered_at'])
              : null,
      readAt:
          json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "conversation_id": conversationId, // 🔑 include it
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
    String? conversationId,
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
      conversationId: conversationId ?? this.conversationId,
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
      files: (json['files'] as List).map((e) => ChatFile.fromJson(e)).toList(),
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
  final String?
  data; // optional because sometimes backend might not send full data

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

  FileMeta({required this.placeholder, required this.num});

  factory FileMeta.fromJson(Map<String, dynamic> json) {
    return FileMeta(placeholder: json['_placeholder'], num: json['num']);
  }

  Map<String, dynamic> toJson() => {"_placeholder": placeholder, "num": num};
}
