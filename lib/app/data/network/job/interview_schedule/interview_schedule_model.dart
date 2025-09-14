// class InterviewScheduleModel {
//   bool? success;
//   String? message;
//   List<InterviewScheduleData>? data;
//
//   InterviewScheduleModel({this.success, this.message, this.data});
//
//   InterviewScheduleModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = List<InterviewScheduleData>.from(
//         json['data'].map((x) => InterviewScheduleData.fromJson(x)),
//       );
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = {};
//     map['success'] = success;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class InterviewScheduleData {
//   String? id;
//   String? job;
//   String? candidate;
//   String? interviewer;
//   String? round;
//   String? interviewType;
//   String? startOn;
//   String? startTime;
//   String? commentForInterviewer;
//   String? commentForCandidate;
//   String? clientId;
//   String? createdBy;
//   String? updatedBy;
//   String? createdAt;
//   String? updatedAt;
//
//   InterviewScheduleData({
//     this.id,
//     this.job,
//     this.candidate,
//     this.interviewer,
//     this.round,
//     this.interviewType,
//     this.startOn,
//     this.startTime,
//     this.commentForInterviewer,
//     this.commentForCandidate,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   InterviewScheduleData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     job = json['job'];
//     candidate = json['candidate'];
//     interviewer = json['interviewer'];
//     round = json['round'];
//     interviewType = json['interviewType'];
//     startOn = json['startOn'];
//     startTime = json['startTime'];
//     commentForInterviewer = json['commentForInterviewer'];
//     commentForCandidate = json['commentForCandidate'];
//     clientId = json['client_id'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = {};
//     map['id'] = id;
//     map['job'] = job;
//     map['candidate'] = candidate;
//     map['interviewer'] = interviewer;
//     map['round'] = round;
//     map['interviewType'] = interviewType;
//     map['startOn'] = startOn;
//     map['startTime'] = startTime;
//     map['commentForInterviewer'] = commentForInterviewer;
//     map['commentForCandidate'] = commentForCandidate;
//     map['client_id'] = clientId;
//     map['created_by'] = createdBy;
//     map['updated_by'] = updatedBy;
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     return map;
//   }
// }
class InterviewScheduleModel {
  bool? success;
  String? message;
  List<InterviewScheduleData>? data;

  InterviewScheduleModel({this.success, this.message, this.data});

  InterviewScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<InterviewScheduleData>.from(
        json['data'].map((x) => InterviewScheduleData.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class InterviewScheduleData {
  String? id;
  String? job;
  String? candidate;
  String? interviewer;
  List<String>? round; // updated
  String? interviewType;
  String? startOn;
  String? startTime;
  String? commentForInterviewer;
  String? commentForCandidate;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  InterviewScheduleData({
    this.id,
    this.job,
    this.candidate,
    this.interviewer,
    this.round,
    this.interviewType,
    this.startOn,
    this.startTime,
    this.commentForInterviewer,
    this.commentForCandidate,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  InterviewScheduleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'];
    candidate = json['candidate'];
    interviewer = json['interviewer'];
    // parse round as List<String>
    if (json['round'] != null) {
      if (json['round'] is List) {
        round = List<String>.from(json['round'].map((x) => x.toString()));
      } else if (json['round'] is String) {
        round = [json['round']];
      }
    } else {
      round = [];
    }
    interviewType = json['interviewType'];
    startOn = json['startOn'];
    startTime = json['startTime'];
    commentForInterviewer = json['commentForInterviewer'];
    commentForCandidate = json['commentForCandidate'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['job'] = job;
    map['candidate'] = candidate;
    map['interviewer'] = interviewer;
    map['round'] = round;
    map['interviewType'] = interviewType;
    map['startOn'] = startOn;
    map['startTime'] = startTime;
    map['commentForInterviewer'] = commentForInterviewer;
    map['commentForCandidate'] = commentForCandidate;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
