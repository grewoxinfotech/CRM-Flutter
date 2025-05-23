class ActivityModel {
  final String id;
  final String relatedId;
  final String activityFrom;
  final String activityId;
  final String action;
  final String performedBy;
  final String activityMessage;
  final String? clientId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ActivityModel({
    required this.id,
    required this.relatedId,
    required this.activityFrom,
    required this.activityId,
    required this.action,
    required this.performedBy,
    required this.activityMessage,
    this.clientId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      relatedId: json['related_id'],
      activityFrom: json['activity_from'],
      activityId: json['activity_id'],
      action: json['action'],
      performedBy: json['performed_by'],
      activityMessage: json['activity_message'],
      clientId: json['client_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'activity_from': activityFrom,
      'activity_id': activityId,
      'action': action,
      'performed_by': performedBy,
      'activity_message': activityMessage,
      'client_id': clientId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
