class FollowUpMeetingModel {
  final String? id;
  final String? title;
  final String? meetingType;
  final String? meetingStatus;
  final String? venue;
  final String? location;
  final String? meetingLink;
  final String? fromDate;
  final String? fromTime;
  final String? toDate;
  final String? toTime;
  final String? host;
  final List<String>? assignedTo;
  final Reminder? reminder;
  final Repeat? repeat;
  final String? participantsReminder;
  final String? priority;
  final String? relatedId;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FollowUpMeetingModel({
    this.id,
    this.title,
    this.meetingType,
    this.meetingStatus,
    this.venue,
    this.location,
    this.meetingLink,
    this.fromDate,
    this.fromTime,
    this.toDate,
    this.toTime,
    this.host,
    this.assignedTo,
    this.reminder,
    this.repeat,
    this.participantsReminder,
    this.priority,
    this.relatedId,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUpMeetingModel.fromJson(Map<String, dynamic> json) {
    return FollowUpMeetingModel(
      id: json['id'],
      title: json['title'],
      meetingType: json['meeting_type'],
      meetingStatus: json['meeting_status'],
      venue: json['venue'],
      location: json['location'],
      meetingLink: json['meeting_link'],
      fromDate: json['from_date'],
      fromTime: json['from_time'],
      toDate: json['to_date'],
      toTime: json['to_time'],
      host: json['host'],
      assignedTo: List<String>.from(json['assigned_to']['assigned_to'] ?? []),
      reminder: json['reminder'] != null ? Reminder.fromJson(json['reminder']) : null,
      repeat: json['repeat'] != null ? Repeat.fromJson(json['repeat']) : null,
      participantsReminder: json['participants_reminder'],
      priority: json['priority'],
      relatedId: json['related_id'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class Reminder {
  final String? reminderDate;
  final String? reminderTime;

  Reminder({this.reminderDate, this.reminderTime});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      reminderDate: json['reminder_date'],
      reminderTime: json['reminder_time'],
    );
  }
}

class Repeat {
  final String? repeatType;
  final String? repeatTimes;
  final String? repeatEndDate;
  final String? repeatEndType;
  final String? repeatStartDate;
  final String? repeatStartTime;
  final List<String>? customRepeatDays;
  final int? customRepeatInterval;
  final String? customRepeatFrequency;

  Repeat({
    this.repeatType,
    this.repeatTimes,
    this.repeatEndDate,
    this.repeatEndType,
    this.repeatStartDate,
    this.repeatStartTime,
    this.customRepeatDays,
    this.customRepeatInterval,
    this.customRepeatFrequency,
  });

  factory Repeat.fromJson(Map<String, dynamic> json) {
    return Repeat(
      repeatType: json['repeat_type'],
      repeatTimes: json['repeat_times'],
      repeatEndDate: json['repeat_end_date'],
      repeatEndType: json['repeat_end_type'],
      repeatStartDate: json['repeat_start_date'],
      repeatStartTime: json['repeat_start_time'],
      customRepeatDays: (json['custom_repeat_days'] as List?)?.map((e) => e.toString()).toList(),
      customRepeatInterval: json['custom_repeat_interval'],
      customRepeatFrequency: json['custom_repeat_frequency'],
    );
  }
}
