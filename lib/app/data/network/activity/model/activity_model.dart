class Activity {
  final String id;
  final String relatedId;
  final String activityFrom;
  final String activityId;
  final String action;
  final String performedBy;
  final String activityMessage;
  final String clientId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Activity({
    required this.id,
    required this.relatedId,
    required this.activityFrom,
    required this.activityId,
    required this.action,
    required this.performedBy,
    required this.activityMessage,
    required this.clientId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      relatedId: json['related_id'] ?? '',
      activityFrom: json['activity_from'] ?? '',
      activityId: json['activity_id'] ?? '',
      action: json['action'] ?? '',
      performedBy: json['performed_by'] ?? '',
      activityMessage: json['activity_message'] ?? '',
      clientId: json['client_id'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }
} 