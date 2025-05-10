class TaskModel {
  final String? id;
  final String? relatedId;
  final String? taskName;
  final String? category;
  final String? project;
  final String? lead;
  final String? file;
  final DateTime? startDate;
  final DateTime? dueDate;
  final Map<String, dynamic>? assignTo;
  final String? status;
  final String? priority;
  final String? description;
  final DateTime? reminderDate;
  final String? clientId;
  final String? taskReporter;
  final String? createdBy;
  final String? updatedBy;

  TaskModel({
    this.id,
    this.relatedId,
    this.taskName,
    this.category,
    this.project,
    this.lead,
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
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      relatedId: json['related_id'],
      taskName: json['taskName'],
      category: json['category'],
      project: json['project'],
      lead: json['lead'],
      file: json['file'],
      startDate: DateTime.parse(json['startDate']),
      dueDate: DateTime.parse(json['dueDate']),
      assignTo: json['assignTo'] ?? {},
      status: json['status'],
      priority: json['priority'],
      description: json['description'],
      reminderDate:
      json['reminder_date'] != null
          ? DateTime.parse(json['reminder_date'])
          : null,
      clientId: json['client_id'],
      taskReporter: json['task_reporter'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'taskName': taskName,
      'category': category,
      'project': project,
      'lead': lead,
      'file': file,
      'startDate': startDate!.toIso8601String(),
      'dueDate': dueDate!.toIso8601String(),
      'assignTo': assignTo,
      'status': status,
      'priority': priority,
      'description': description,
      'reminder_date': reminderDate?.toIso8601String(),
      'client_id': clientId,
      'task_reporter': taskReporter,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}