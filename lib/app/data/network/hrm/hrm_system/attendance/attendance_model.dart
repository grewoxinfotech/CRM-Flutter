class AttendanceModel {
  bool? success;
  String? message;
  List<AttendanceData>? data;

  AttendanceModel({this.success, this.message, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<AttendanceData>.from(
        json['data'].map((x) => AttendanceData.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AttendanceMessage {
  List<AttendanceData>? data;
  Pagination? pagination;

  AttendanceMessage({this.data, this.pagination});

  AttendanceMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<AttendanceData>.from(
        json['data'].map((x) => AttendanceData.fromJson(x)),
      );
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

class AttendanceData {
  String? id;
  String? employee;
  String? date;
  String? startTime;
  String? endTime;
  String? late;
  bool? halfDay;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  AttendanceData({
    this.id,
    this.employee,
    this.date,
    this.startTime,
    this.endTime,
    this.late,
    this.halfDay,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  AttendanceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    late = json['late'];
    halfDay = json['halfDay'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['employee'] = employee;
    map['date'] = date;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['late'] = late;
    map['halfDay'] = halfDay;
    map['client_id'] = clientId;
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
