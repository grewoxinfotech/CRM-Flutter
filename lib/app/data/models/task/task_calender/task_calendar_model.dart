class TaskCalendarModel {
  final String id;
  final String taskName;
  final DateTime taskDate;
  final String taskTime;
  final String taskDescription;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskCalendarModel({
    required this.id,
    required this.taskName,
    required this.taskDate,
    required this.taskTime,
    required this.taskDescription,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskCalendarModel.fromJson(Map<String, dynamic> json) {
    return TaskCalendarModel(
      id: json['id'],
      taskName: json['taskName'],
      taskDate: DateTime.parse(json['taskDate']),
      taskTime: json['taskTime'],
      taskDescription: json['taskDescription'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDate': taskDate.toIso8601String(),
      'taskTime': taskTime,
      'taskDescription': taskDescription,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
