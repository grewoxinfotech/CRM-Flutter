// class LeaveModel {
//   final String id;
//   final String employeeId;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String leaveType;
//   final String reason;
//   final String status;
//   final String? remarks;
//   final bool isHalfDay;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   LeaveModel({
//     required this.id,
//     required this.employeeId,
//     required this.startDate,
//     required this.endDate,
//     required this.leaveType,
//     required this.reason,
//     required this.status,
//     this.remarks,
//     required this.isHalfDay,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory LeaveModel.fromJson(Map<String, dynamic> json) {
//     return LeaveModel(
//       id: json['id'],
//       employeeId: json['employeeId'],
//       startDate: DateTime.parse(json['startDate']),
//       endDate: DateTime.parse(json['endDate']),
//       leaveType: json['leaveType'],
//       reason: json['reason'],
//       status: json['status'],
//       remarks: json['remarks'],
//       isHalfDay: json['isHalfDay'],
//       clientId: json['client_id'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'employeeId': employeeId,
//       'startDate': startDate.toIso8601String(),
//       'endDate': endDate.toIso8601String(),
//       'leaveType': leaveType,
//       'reason': reason,
//       'status': status,
//       'remarks': remarks,
//       'isHalfDay': isHalfDay,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }
class LeaveModel {
  bool? success;
  LeaveMessage? message;
  dynamic data;

  LeaveModel({this.success, this.message, this.data});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] != null
        ? LeaveMessage.fromJson(json['message'])
        : null;
    data = json['message']?['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message']?['data'] = data;
    return map;
  }
}

class LeaveMessage {
  List<LeaveData>? data;
  Pagination? pagination;

  LeaveMessage({this.data, this.pagination});

  LeaveMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<LeaveData>.from(
        json['data'].map((x) => LeaveData.fromJson(x)),
      );
    }
    pagination = json['pagination'] != null
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

class LeaveData {
  String? id;
  String? employeeId;
  String? leaveType;
  String? reason;
  String? status;
  String? remarks;
  bool? isHalfDay;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? startDate;
  String? endDate;

  LeaveData({
    this.id,
    this.employeeId,
    this.startDate,
    this.endDate,
    this.leaveType,
    this.reason,
    this.status,
    this.remarks,
    this.isHalfDay,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  LeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    leaveType = json['leaveType'];
    reason = json['reason'];
    status = json['status'];
    remarks = json['remarks'];
    isHalfDay = json['isHalfDay'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['employeeId'] = employeeId;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['leaveType'] = leaveType;
    map['reason'] = reason;
    map['status'] = status;
    map['remarks'] = remarks;
    map['isHalfDay'] = isHalfDay;
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
