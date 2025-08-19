class HolidayModel {
  bool? success;
  HolidayMessage? message;
  dynamic data;

  HolidayModel({this.success, this.message, this.data});

  HolidayModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? HolidayMessage.fromJson(json['message'])
            : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['data'] = data;
    return map;
  }
}

class HolidayMessage {
  List<HolidayData>? data;
  Pagination? pagination;

  HolidayMessage({this.data, this.pagination});

  HolidayMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<HolidayData>.from(
        json['data'].map((x) => HolidayData.fromJson(x)),
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

class HolidayData {
  String? id;
  String? holidayName;
  String? leaveType;
  String? startDate;
  String? endDate;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? section;
  String? key;

  HolidayData({
    this.id,
    this.holidayName,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.section,
    this.key,
  });

  HolidayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holidayName = json['holiday_name'];
    leaveType = json['leave_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['holiday_name'] = holidayName;
    map['leave_type'] = leaveType;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['client_id'] = clientId;
    map['section'] = section;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
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
