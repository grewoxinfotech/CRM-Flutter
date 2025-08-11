class Activity {
  final String? id;
  final String? relatedId;
  final String? activityFrom;
  final String? activityId;
  final String? action;
  final String? performedBy;
  final String? activityMessage;
  final String? clientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Activity({
    this.id,
    this.relatedId,
    this.activityFrom,
    this.activityId,
    this.action,
    this.performedBy,
    this.activityMessage,
    this.clientId,
    this.createdAt,
    this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      relatedId: json['related_id'],
      activityFrom: json['activity_from'],
      activityId: json['activity_id'],
      action: json['action'],
      performedBy: json['performed_by'],
      activityMessage: json['activity_message'],
      clientId: json['client_id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
} 