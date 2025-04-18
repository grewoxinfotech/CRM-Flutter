import 'dart:convert';

class InterviewScheduleModel {
  final String id;
  final String job;
  final String candidate;
  final String interviewer;
  final List<String> round;
  final String interviewType;
  final DateTime startOn;
  final String startTime;
  final String commentForInterviewer;
  final String commentForCandidate;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  InterviewScheduleModel({
    required this.id,
    required this.job,
    required this.candidate,
    required this.interviewer,
    required this.round,
    required this.interviewType,
    required this.startOn,
    required this.startTime,
    required this.commentForInterviewer,
    required this.commentForCandidate,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InterviewScheduleModel.fromJson(Map<String, dynamic> json) {
    return InterviewScheduleModel(
      id: json['id'],
      job: json['job'],
      candidate: json['candidate'],
      interviewer: json['interviewer'],
      round: List<String>.from(jsonDecode(json['round'] ?? '[]')),
      interviewType: json['interviewType'],
      startOn: DateTime.parse(json['startOn']),
      startTime: json['startTime'],
      commentForInterviewer: json['commentForInterviewer'],
      commentForCandidate: json['commentForCandidate'],
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
      "job": job,
      "candidate": candidate,
      "interviewer": interviewer,
      "round": jsonEncode(round),
      "interviewType": interviewType,
      "startOn": startOn.toIso8601String(),
      "startTime": startTime,
      "commentForInterviewer": commentForInterviewer,
      "commentForCandidate": commentForCandidate,
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
