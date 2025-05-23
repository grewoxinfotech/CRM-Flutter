class AttendanceModel {
  final String? id;
  final String? employee;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? late;
  final bool? halfDay;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceModel({
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

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      employee: json['employee'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      late: json['late'],
      halfDay: json['halfDay'],
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
      'employee': employee,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'late': late,
      'halfDay': halfDay,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
