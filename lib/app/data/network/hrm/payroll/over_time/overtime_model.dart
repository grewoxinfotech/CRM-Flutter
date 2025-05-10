class OvertimeModel {
  final String id;
  final String employeeId;
  final String title;
  final String days;
  final String hours;
  final String rate;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  OvertimeModel({
    required this.id,
    required this.employeeId,
    required this.title,
    required this.days,
    required this.hours,
    required this.rate,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OvertimeModel.fromJson(Map<String, dynamic> json) {
    return OvertimeModel(
      id: json['id'],
      employeeId: json['employeeId'],
      title: json['title'],
      days: json['days'],
      hours: json['Hours'],
      rate: json['rate'],
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
      'title': title,
      'days': days,
      'Hours': hours,
      'rate': rate,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
