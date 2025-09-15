// class TaskModel {
//   final String? id;
//   final String? relatedId;
//   final String? taskName;
//   final String? file;
//   final String? startDate;
//   final String? dueDate;
//   final Map<String, dynamic>? assignTo;
//   final String? status;
//   final String? priority;
//   final String? description;
//   final String? reminderDate;
//   final String? clientId;
//   final String? taskReporter;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//
//   TaskModel({
//     this.id,
//     this.relatedId,
//     this.taskName,
//     this.file,
//     this.startDate,
//     this.dueDate,
//     this.assignTo,
//     this.status,
//     this.priority,
//     this.description,
//     this.reminderDate,
//     this.clientId,
//     this.taskReporter,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory TaskModel.fromJson(Map<String, dynamic> json) {
//     return TaskModel(
//       id: json['id'],
//       relatedId: json['related_id'],
//       taskName: json['taskName'],
//       file: json['file'],
//       startDate: json['startDate'],
//       dueDate: json['dueDate'],
//       assignTo: json['assignTo'],
//       status: json['status'],
//       priority: json['priority'],
//       description: json['description'],
//       reminderDate: json['reminder_date'],
//       clientId: json['client_id'],
//       taskReporter: json['task_reporter'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'related_id': relatedId,
//       'taskName': taskName,
//       'file': file,
//       'startDate': startDate,
//       'dueDate': dueDate,
//       'assignTo': assignTo,
//       'status': status,
//       'priority': priority,
//       'description': description,
//       'reminder_date': reminderDate,
//       'client_id': clientId,
//       'task_reporter': taskReporter,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }
// }

class TaskModel {
  bool? success;
  TaskMessage? message;
  dynamic data;

  TaskModel({this.success, this.message, this.data});

  TaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? TaskMessage.fromJson(json['message']) : null;
    data = json['message'] != null ? json['message']['data'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
      map['message']['data'] = data;
    }
    return map;
  }
}

class TaskMessage {
  List<TaskData>? data;
  Pagination? pagination;

  TaskMessage({this.data, this.pagination});

  TaskMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<TaskData>.from(json['data'].map((x) => TaskData.fromJson(x)));
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class TaskData {
  String? id;
  String? relatedId;
  String? taskName;
  String? file;
  String? startDate;
  String? dueDate;
  Map<String, dynamic>? assignTo;
  String? status;
  String? priority;
  String? description;
  String? reminderDate;
  String? clientId;
  String? taskReporter;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  TaskData({
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

  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relatedId = json['related_id'];
    taskName = json['taskName'];
    file = json['file'];
    startDate = json['startDate'];
    dueDate = json['dueDate'];
    assignTo = json['assignTo'];
    status = json['status'];
    priority = json['priority'];
    description = json['description'];
    reminderDate = json['reminder_date'];
    clientId = json['client_id'];
    taskReporter = json['task_reporter'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['related_id'] = relatedId;
    map['taskName'] = taskName;
    map['file'] = file;
    map['startDate'] = startDate;
    map['dueDate'] = dueDate;
    map['assignTo'] = assignTo;
    map['status'] = status;
    map['priority'] = priority;
    map['description'] = description;
    map['reminder_date'] = reminderDate;
    map['client_id'] = clientId;
    map['task_reporter'] = taskReporter;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
