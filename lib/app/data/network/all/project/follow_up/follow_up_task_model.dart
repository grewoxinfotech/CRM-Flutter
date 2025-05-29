class FollowUpTaskModel {
  final String? id;
  final String? subject;
  final String? dueDate;
  final String? priority;
  final String? taskReporter;
  final List<String>? assignedTo;
  final String? status;
  final Reminder? reminder;
  final Repeat? repeat;
  final String? description;
  final String? relatedId;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FollowUpTaskModel({
    this.id,
    this.subject,
    this.dueDate,
    this.priority,
    this.taskReporter,
    this.assignedTo,
    this.status,
    this.reminder,
    this.repeat,
    this.description,
    this.relatedId,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUpTaskModel.fromJson(Map<String, dynamic> json) {
    return FollowUpTaskModel(
      id: json['id'],
      subject: json['subject'],
      dueDate: json['due_date'],
      priority: json['priority'],
      taskReporter: json['task_reporter'],
      assignedTo: List<String>.from(json['assigned_to']['assigned_to'] ?? []),
      status: json['status'],
      reminder:
          json['reminder'] != null ? Reminder.fromJson(json['reminder']) : null,
      repeat: json['repeat'] != null ? Repeat.fromJson(json['repeat']) : null,
      description: json['description'],
      relatedId: json['related_id'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
  final int? repeatTimes;
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
      customRepeatDays:
          (json['custom_repeat_days'] as List?)
              ?.map((e) => e.toString())
              .toList(),
      customRepeatInterval: json['custom_repeat_interval'],
      customRepeatFrequency: json['custom_repeat_frequency'],
    );
  }
}
