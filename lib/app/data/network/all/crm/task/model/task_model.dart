class TaskModel {
  final String id;
  final String relatedId;
  final String taskName;
  final String file;
  final DateTime startDate;
  final DateTime dueDate;
  final AssignTo assignTo;
  final String status;
  final String priority;
  final String description;
  final DateTime reminderDate;
  final String clientId;
  final String taskReporter;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskModel({
    required this.id,
    required this.relatedId,
    required this.taskName,
    required this.file,
    required this.startDate,
    required this.dueDate,
    required this.assignTo,
    required this.status,
    required this.priority,
    required this.description,
    required this.reminderDate,
    required this.clientId,
    required this.taskReporter,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      relatedId: json['related_id'] ?? '',
      taskName: json['taskName'] ?? '',
      file: json['file'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      dueDate: DateTime.parse(json['dueDate']),
      assignTo: AssignTo.fromJson(json['assignTo']),
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      description: json['description'] ?? '',
      reminderDate: DateTime.parse(json['reminder_date']),
      clientId: json['client_id'] ?? '',
      taskReporter: json['task_reporter'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'taskName': taskName,
      'file': file,
      'startDate': startDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'assignTo': assignTo.toJson(),
      'status': status,
      'priority': priority,
      'description': description,
      'reminder_date': reminderDate.toIso8601String(),
      'client_id': clientId,
      'task_reporter': taskReporter,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AssignTo {
  final List<String> assignedUsers;

  AssignTo({required this.assignedUsers});

  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(
      assignedUsers: List<String>.from(json['assignedusers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignedusers': assignedUsers,
    };
  }
}
