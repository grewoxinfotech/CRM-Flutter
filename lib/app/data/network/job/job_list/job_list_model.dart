class JobListModel {
  bool? success;
  JobMessage? message;
  dynamic data;

  JobListModel({this.success, this.message, this.data});

  JobListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? JobMessage.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['data'] = data;
    return map;
  }
}

class JobMessage {
  List<JobData>? data;
  Pagination? pagination;

  JobMessage({this.data, this.pagination});

  JobMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<JobData>.from(json['data'].map((x) => JobData.fromJson(x)));
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class JobData {
  String? id;
  String? title;
  String? category;
  JobSkills? skills;
  String? location;
  JobInterviewRounds? interviewRounds;
  String? startDate;
  String? endDate;
  int? totalOpenings;
  String? status;
  String? recruiter;
  String? jobType;
  String? workExperience;
  String? currency;
  String? expectedSalary;
  String? description;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  JobData({
    this.id,
    this.title,
    this.category,
    this.skills,
    this.location,
    this.interviewRounds,
    this.startDate,
    this.endDate,
    this.totalOpenings,
    this.status,
    this.recruiter,
    this.jobType,
    this.workExperience,
    this.currency,
    this.expectedSalary,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  JobData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    skills = json['skills'] != null ? JobSkills.fromJson(json['skills']) : null;
    location = json['location'];
    interviewRounds =
        json['interviewRounds'] != null
            ? JobInterviewRounds.fromJson(json['interviewRounds'])
            : null;
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalOpenings = json['totalOpenings'];
    status = json['status'];
    recruiter = json['recruiter'];
    jobType = json['jobType'];
    workExperience = json['workExperience'];
    currency = json['currency'];
    expectedSalary = json['expectedSalary'];
    description = json['description'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    if (skills != null) {
      map['skills'] = skills!.toJson();
    }
    map['location'] = location;
    if (interviewRounds != null) {
      map['interviewRounds'] = interviewRounds!.toJson();
    }
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['totalOpenings'] = totalOpenings;
    map['status'] = status;
    map['recruiter'] = recruiter;
    map['jobType'] = jobType;
    map['workExperience'] = workExperience;
    map['currency'] = currency;
    map['expectedSalary'] = expectedSalary;
    map['description'] = description;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
  }
}

class JobSkills {
  List<String> skills;

  JobSkills({required this.skills});

  JobSkills.fromJson(Map<String, dynamic> json)
      : skills = (json['Skills'] is List
      ? (json['Skills'] as List).map((e) => e.toString()).toList()
      : json['Skills'] != null
      ? [json['Skills'].toString()]
      : []);

  Map<String, dynamic> toJson() {
    return {
      'Skills': skills,
    };
  }
}

class JobInterviewRounds {
  List<String> interviewRounds;

  JobInterviewRounds({required this.interviewRounds});

  JobInterviewRounds.fromJson(Map<String, dynamic> json)
      : interviewRounds = (json['InterviewRounds'] is List
      ? (json['InterviewRounds'] as List).map((e) => e.toString()).toList()
      : json['InterviewRounds'] != null
      ? [json['InterviewRounds'].toString()]
      : []);

  Map<String, dynamic> toJson() {
    return {
      'InterviewRounds': interviewRounds,
    };
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
