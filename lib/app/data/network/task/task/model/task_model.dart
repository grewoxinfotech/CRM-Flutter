class TaskModel {
  final String? id;
  final String? relatedId;
  final String? taskName;
  final String? file;
  final String? startDate;
  final String? dueDate;
  final Map<String, dynamic>? assignTo;
  final String? status;
  final String? priority;
  final String? description;
  final String? reminderDate;
  final String? clientId;
  final String? taskReporter;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  TaskModel({
    this.id,
    this.relatedId,
    this.taskName,
    this.file,
    this.startDate,
    this.dueDate,
    this.assignTo,
    this.status,
    this.priority,
    this.description,
    this.reminderDate,
    this.clientId,
    this.taskReporter,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      relatedId: json['related_id'],
      taskName: json['taskName'],
      file: json['file'],
      startDate: json['startDate'],
      dueDate: json['dueDate'],
      assignTo: json['assignTo'],
      status: json['status'],
      priority: json['priority'],
      description: json['description'],
      reminderDate: json['reminder_date'],
      clientId: json['client_id'],
      taskReporter: json['task_reporter'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'taskName': taskName,
      'file': file,
      'startDate': startDate,
      'dueDate': dueDate,
      'assignTo': assignTo,
      'status': status,
      'priority': priority,
      'description': description,
      'reminder_date': reminderDate,
      'client_id': clientId,
      'task_reporter': taskReporter,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}