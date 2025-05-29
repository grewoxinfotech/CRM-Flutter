class FollowUpCallModel {
  final String id;
  final String subject;
  final String callStartDate;
  final String callStartTime;
  final String? callEndTime;
  final String? callDuration;
  final List<String> assignedTo;
  final String callPurpose;
  final String? callReminder;
  final String callNotes;
  final String callType;
  final String callStatus;
  final String priority;
  final String relatedId;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  FollowUpCallModel({
    required this.id,
    required this.subject,
    required this.callStartDate,
    required this.callStartTime,
    this.callEndTime,
    this.callDuration,
    required this.assignedTo,
    required this.callPurpose,
    this.callReminder,
    required this.callNotes,
    required this.callType,
    required this.callStatus,
    required this.priority,
    required this.relatedId,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FollowUpCallModel.fromJson(Map<String, dynamic> json) {
    return FollowUpCallModel(
      id: json['id'],
      subject: json['subject'],
      callStartDate: json['call_start_date'],
      callStartTime: json['call_start_time'],
      callEndTime: json['call_end_time'],
      callDuration: json['call_duration'],
      assignedTo: List<String>.from(json['assigned_to']?['assigned_to'] ?? []),
      callPurpose: json['call_purpose'],
      callReminder: json['call_reminder'],
      callNotes: json['call_notes'],
      callType: json['call_type'],
      callStatus: json['call_status'],
      priority: json['priority'],
      relatedId: json['related_id'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject': subject,
    'call_start_date': callStartDate,
    'call_start_time': callStartTime,
    'call_end_time': callEndTime,
    'call_duration': callDuration,
    'assigned_to': {
      'assigned_to': assignedTo,
    },
    'call_purpose': callPurpose,
    'call_reminder': callReminder,
    'call_notes': callNotes,
    'call_type': callType,
    'call_status': callStatus,
    'priority': priority,
    'related_id': relatedId,
    'client_id': clientId,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
