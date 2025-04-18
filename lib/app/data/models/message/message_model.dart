class MessageModel {
  final String senderId;
  final String message;
  final DateTime timestamp;
  final String status;
  final DateTime deliveredAt;
  final DateTime readAt;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.deliveredAt,
    required this.readAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['sender_id'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      deliveredAt: DateTime.parse(json['delivered_at']),
      readAt: DateTime.parse(json['read_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'delivered_at': deliveredAt.toIso8601String(),
      'read_at': readAt.toIso8601String(),
    };
  }
}
