import 'dart:convert';

class JobModel {
  final String id;
  final String title;
  final String category;
  final Map<String, dynamic>? skills;
  final Map<String, dynamic>? interviewRounds;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final int totalOpenings;
  final String status;
  final String recruiter;
  final String jobType;
  final String workExperience;
  final String currency;
  final String expectedSalary;
  final String description;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobModel({
    required this.id,
    required this.title,
    required this.category,
    required this.skills,
    required this.interviewRounds,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.totalOpenings,
    required this.status,
    required this.recruiter,
    required this.jobType,
    required this.workExperience,
    required this.currency,
    required this.expectedSalary,
    required this.description,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      skills: json['skills'] != null ? Map<String, dynamic>.from(jsonDecode(json['skills'])) : null,
      interviewRounds: json['interviewRounds'] != null ? Map<String, dynamic>.from(jsonDecode(json['interviewRounds'])) : null,
      location: json['location'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      totalOpenings: json['totalOpenings'],
      status: json['status'],
      recruiter: json['recruiter'],
      jobType: json['jobType'],
      workExperience: json['workExperience'],
      currency: json['currency'],
      expectedSalary: json['expectedSalary'],
      description: json['description'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "category": category,
      "skills": jsonEncode(skills),
      "interviewRounds": jsonEncode(interviewRounds),
      "location": location,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "totalOpenings": totalOpenings,
      "status": status,
      "recruiter": recruiter,
      "jobType": jobType,
      "workExperience": workExperience,
      "currency": currency,
      "expectedSalary": expectedSalary,
      "description": description,
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
