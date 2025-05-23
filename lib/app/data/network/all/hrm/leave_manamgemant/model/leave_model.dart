class LeaveModel {
  final String? id;
  final String? employeeId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? leaveType;
  final String? reason;
  final String? status;
  final String? remarks;
  final bool? isHalfDay;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeaveModel({
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

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'],
      employeeId: json['employeeId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      leaveType: json['leaveType'],
      reason: json['reason'],
      status: json['status'],
      remarks: json['remarks'],
      isHalfDay: json['isHalfDay'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'startDate': startDate!.toIso8601String(),
      'endDate': endDate!.toIso8601String(),
      'leaveType': leaveType,
      'reason': reason,
      'status': status,
      'remarks': remarks,
      'isHalfDay': isHalfDay,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
