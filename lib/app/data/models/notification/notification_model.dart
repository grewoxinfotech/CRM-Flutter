class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String userId;
  final DateTime timestamp;
  final bool isRead;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.timestamp,
    required this.isRead,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
      clientId: json['clientId'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'clientId': clientId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}