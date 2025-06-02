class HolidayModel {
  final String id;
  final String holidayName;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;

  HolidayModel({
    required this.id,
    required this.holidayName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      id: json['id'] ?? '',
      holidayName: json['holiday_name'] ?? '',
      leaveType: json['leave_type'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'holiday_name': holidayName,
      'leave_type': leaveType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'key': key,
    };
  }
}
