class AttendanceModel {
  final String id;
  final String employee;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String? late;
  final bool halfDay;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceModel({
    required this.id,
    required this.employee,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.late,
    required this.halfDay,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? '',
      employee: json['employee'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      late: json['late'],
      halfDay: json['halfDay'] ?? false,
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': employee,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'late': late,
      'halfDay': halfDay,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
