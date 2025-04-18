import 'dart:convert';

class ProjectReportModel {
  final String id;
  final String project;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, dynamic> projectMembers;
  final String completion;
  final String status;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectReportModel({
    required this.id,
    required this.project,
    required this.startDate,
    required this.endDate,
    required this.projectMembers,
    required this.completion,
    required this.status,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectReportModel.fromJson(Map<String, dynamic> json) {
    return ProjectReportModel(
      id: json['id'],
      project: json['project'],
      startDate: DateTime.parse(json['startdate']),
      endDate: DateTime.parse(json['enddate']),
      projectMembers: jsonDecode(json['projectMembers']),
      completion: json['completion'],
      status: json['status'] ?? '',
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project': project,
      'startdate': startDate.toIso8601String(),
      'enddate': endDate.toIso8601String(),
      'projectMembers': jsonEncode(projectMembers),
      'completion': completion,
      'status': status,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
