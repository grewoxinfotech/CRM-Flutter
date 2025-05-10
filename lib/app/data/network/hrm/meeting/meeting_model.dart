class MeetingModel {
  final String id;
  final String title;
  final String description;
  final String department;
  final String employee;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String meetingLink;
  final String? client;
  final String status;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  MeetingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.department,
    required this.employee,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.meetingLink,
    this.client,
    required this.status,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      department: json['department'],
      employee: json['employee'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      meetingLink: json['meetingLink'],
      client: json['client'],
      status: json['status'],
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
      'title': title,
      'description': description,
      'department': department,
      'employee': employee,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'meetingLink': meetingLink,
      'client': client,
      'status': status,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
