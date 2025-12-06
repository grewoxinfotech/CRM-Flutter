class MeetingData {
  String? id;
  String? title;
  String? description;
  String? department;
  List<String>? employee;
  String? date;
  String? startTime;
  String? endTime;
  String? meetingLink;
  String? client;
  String? section;
  String? status;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  MeetingData({
    this.id,
    this.title,
    this.description,
    this.department,
    this.employee,
    this.section,
    this.date,
    this.startTime,
    this.endTime,
    this.meetingLink,
    this.client,
    this.status,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  MeetingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    department = json['department'];
    employee =
        json['employee'] != null ? List<String>.from(json['employee']) : null;
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    meetingLink = json['meetingLink'];
    client = json['client'];
    status = json['status'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'department': department,
    'employee': employee,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'meetingLink': meetingLink,
    'client': client,
    'status': status,
    'section': status,
    'client_id': clientId,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'key': key,
  };
}

class MeetingModel {
  bool? success;
  MeetingMessage? message;
  dynamic data;

  MeetingModel({this.success, this.message, this.data});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? MeetingMessage.fromJson(json['message'])
            : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message?.toJson(),
    'data': data,
  };
}

class MeetingMessage {
  List<MeetingData>? data;
  Pagination? pagination;

  MeetingMessage({this.data, this.pagination});

  MeetingMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<MeetingData>.from(
        (json['data'] as List).map((x) => MeetingData.fromJson(x)),
      );
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((v) => v.toJson()).toList(),
    'pagination': pagination?.toJson(),
  };
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

  Map<String, dynamic> toJson() => {
    'total': total,
    'current': current,
    'pageSize': pageSize,
    'totalPages': totalPages,
  };
}
