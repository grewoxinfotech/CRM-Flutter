class FollowUpTaskModel {
  final String? id;
  final String? updatedBy;
  final String? subject;
  final String? dueDate;
  final String? priority;
  final AssignedTo? assignedTo;
  final String? status;
  final String? description;
  final Reminder? reminder;
  final String? taskReporter;
  final Repeat? repeat;
  final String? clientId;
  final String? relatedId;
  final String? createdBy;
  final String? updatedAt;
  final String? createdAt;

  FollowUpTaskModel({
    this.id,
    this.updatedBy,
    this.subject,
    this.dueDate,
    this.priority,
    this.assignedTo,
    this.status,
    this.description,
    this.reminder,
    this.taskReporter,
    this.repeat,
    this.clientId,
    this.relatedId,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
  });

  factory FollowUpTaskModel.fromJson(Map<String, dynamic> json) {
    return FollowUpTaskModel(
      id: json['id'],
      updatedBy: json['updated_by'],
      subject: json['subject'],
      dueDate: json['due_date'],
      priority: json['priority'],
      assignedTo: json['assigned_to'] != null
          ? AssignedTo.fromJson(json['assigned_to'])
          : null,
      status: json['status'],
      description: json['description'],
      reminder:
          json['reminder'] != null ? Reminder.fromJson(json['reminder']) : null,
      taskReporter: json['task_reporter'],
      repeat: json['repeat'] != null ? Repeat.fromJson(json['repeat']) : null,
      clientId: json['client_id'],
      relatedId: json['related_id'],
      createdBy: json['created_by'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'due_date': dueDate,
      'priority': priority,
      'assigned_to': assignedTo?.toJson(),
      'status': status,
      'description': description,
      'reminder': reminder?.toJson(),
      'repeat': repeat?.toJson(),
      'client_id': clientId,
      'related_id': relatedId,
    };
  }
}

class AssignedTo {
  final List<String>? assignedTo;

  AssignedTo({this.assignedTo});

  factory AssignedTo.fromJson(Map<String, dynamic> json) {
    return AssignedTo(
      assignedTo: json['assigned_to'] != null
          ? List<String>.from(json['assigned_to'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned_to': assignedTo,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'reminder_date': reminderDate,
      'reminder_time': reminderTime,
    };
  }
}

class Repeat {
  final String? repeatType;
  final String? repeatEndType;
  final int? repeatTimes;
  final String? repeatEndDate;
  final String? repeatStartDate;
  final String? repeatStartTime;
  final String? customRepeatInterval;
  final String? customRepeatDays;
  final String? customRepeatFrequency;

  Repeat({
    this.repeatType,
    this.repeatEndType,
    this.repeatTimes,
    this.repeatEndDate,
    this.repeatStartDate,
    this.repeatStartTime,
    this.customRepeatInterval,
    this.customRepeatDays,
    this.customRepeatFrequency,
  });

  factory Repeat.fromJson(Map<String, dynamic> json) {
    return Repeat(
      repeatType: json['repeat_type'],
      repeatEndType: json['repeat_end_type'],
      repeatTimes: json['repeat_times'],
      repeatEndDate: json['repeat_end_date'],
      repeatStartDate: json['repeat_start_date'],
      repeatStartTime: json['repeat_start_time'],
      customRepeatInterval: json['custom_repeat_interval'],
      customRepeatDays: json['custom_repeat_days'],
      customRepeatFrequency: json['custom_repeat_frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'repeat_type': repeatType,
      'repeat_end_type': repeatEndType,
      'repeat_times': repeatTimes,
      'repeat_end_date': repeatEndDate,
      'repeat_start_date': repeatStartDate,
      'repeat_start_time': repeatStartTime,
      'custom_repeat_interval': customRepeatInterval,
      'custom_repeat_days': customRepeatDays,
      'custom_repeat_frequency': customRepeatFrequency,
    };
  }
}
