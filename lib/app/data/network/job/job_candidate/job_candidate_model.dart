class JobCandidateModel {
  bool? success;
  JobCandidateMessage? message;
  dynamic data;

  JobCandidateModel({this.success, this.message, this.data});

  JobCandidateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? JobCandidateMessage.fromJson(json['message'])
            : null;
    data = json['message'] != null ? json['message']['data'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message'] ??= {};
    map['message']['data'] = data;
    return map;
  }
}

class JobCandidateMessage {
  List<JobCandidateData>? data;
  Pagination? pagination;

  JobCandidateMessage({this.data, this.pagination});

  JobCandidateMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<JobCandidateData>.from(
        json['data'].map((x) => JobCandidateData.fromJson(x)),
      );
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

class JobCandidateData {
  String? id;
  String? job;
  String? phoneCode;
  String? name;
  String? cvPath;
  String? email;
  String? phone;
  String? location;
  String? totalExperience;
  String? currentLocation;
  String? noticePeriod;
  String? status;
  String? appliedSource;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  JobCandidateData({
    this.id,
    this.job,
    this.phoneCode,
    this.name,
    this.cvPath,
    this.email,
    this.phone,
    this.location,
    this.totalExperience,
    this.currentLocation,
    this.noticePeriod,
    this.status,
    this.appliedSource,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  JobCandidateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'];
    phoneCode = json['phoneCode'];
    name = json['name'];
    cvPath = json['cv_path'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    totalExperience = json['total_experience'];
    currentLocation = json['current_location'];
    noticePeriod = json['notice_period'];
    status = json['status'];
    appliedSource = json['applied_source'];
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
    map['job'] = job;
    map['phoneCode'] = phoneCode;
    map['name'] = name;
    map['cv_path'] = cvPath;
    map['email'] = email;
    map['phone'] = phone;
    map['location'] = location;
    map['total_experience'] = totalExperience;
    map['current_location'] = currentLocation;
    map['notice_period'] = noticePeriod;
    map['status'] = status;
    map['applied_source'] = appliedSource;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
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
