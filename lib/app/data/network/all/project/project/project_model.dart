import 'dart:convert';

class ProjectModel {
  final String id;
  final String projectName;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, dynamic> projectMembers;
  final String projectCategory;
  final String projectDescription;
  final String client;
  final String currency;
  final double budget;
  final String estimatedMonths;
  final int estimatedHours;
  final dynamic files;
  final dynamic tag;
  final String status;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectModel({
    required this.id,
    required this.projectName,
    required this.startDate,
    required this.endDate,
    required this.projectMembers,
    required this.projectCategory,
    required this.projectDescription,
    required this.client,
    required this.currency,
    required this.budget,
    required this.estimatedMonths,
    required this.estimatedHours,
    this.files,
    this.tag,
    required this.status,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      projectName: json['project_name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      projectMembers: jsonDecode(json['project_members']),
      projectCategory: json['project_category'],
      projectDescription: json['project_description'],
      client: json['client'],
      currency: json['currency'],
      budget: json['budget'].toDouble(),
      estimatedMonths: json['estimatedmonths'],
      estimatedHours: json['estimatedhours'],
      files: json['files'],
      tag: json['tag'],
      status: json['status'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_name': projectName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'project_members': jsonEncode(projectMembers),
      'project_category': projectCategory,
      'project_description': projectDescription,
      'client': client,
      'currency': currency,
      'budget': budget,
      'estimatedmonths': estimatedMonths,
      'estimatedhours': estimatedHours,
      'files': files,
      'tag': tag,
      'status': status,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
