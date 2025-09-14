class JobApplicationModel {
  bool? success;
  JobApplicationMessage? message;
  dynamic data;

  JobApplicationModel({this.success, this.message, this.data});

  JobApplicationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] != null
        ? JobApplicationMessage.fromJson(json['message'])
        : null;
    data = json['message']?['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message']?['data'] = data;
    return map;
  }
}

class JobApplicationMessage {
  List<JobApplicationData>? data;
  Pagination? pagination;

  JobApplicationMessage({this.data, this.pagination});

  JobApplicationMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<JobApplicationData>.from(
        json['data'].map((x) => JobApplicationData.fromJson(x)),
      );
    }
    pagination = json['pagination'] != null
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

class JobApplicationData {
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

  JobApplicationData({
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

  JobApplicationData.fromJson(Map<String, dynamic> json) {
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
