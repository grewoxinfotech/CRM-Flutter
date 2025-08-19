// class LeaveTypeModel {
//   final String id;
//   final String leaveType;
//   final int daysPerYear;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   LeaveTypeModel({
//     required this.id,
//     required this.leaveType,
//     required this.daysPerYear,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
//     return LeaveTypeModel(
//       id: json['id'],
//       leaveType: json['leaveType'],
//       daysPerYear: json['daysPerYear'],
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
//       'leaveType': leaveType,
//       'daysPerYear': daysPerYear,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

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

class LeaveData {
  String? id;
  String? employeeId;
  String? startDate;
  String? endDate;
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
  String? key;

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
    this.key,
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
    key = json['key'];
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
