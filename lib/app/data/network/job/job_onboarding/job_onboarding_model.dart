class JobOnboardingModel {
  bool? success;
  JobOnboardingMessage? message;
  dynamic data;

  JobOnboardingModel({this.success, this.message, this.data});

  JobOnboardingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] != null
        ? JobOnboardingMessage.fromJson(json['message'])
        : null;
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

class JobOnboardingMessage {
  List<JobOnboardingData>? data;
  Pagination? pagination;

  JobOnboardingMessage({this.data, this.pagination});

  JobOnboardingMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<JobOnboardingData>.from(
        json['data'].map((x) => JobOnboardingData.fromJson(x)),
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

class JobOnboardingData {
  String? id;
  String? interviewer;
  String? joiningDate;
  String? daysOfWeek;
  String? salary;
  String? currency;
  String? salaryType;
  String? salaryDuration;
  String? jobType;
  String? status;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  JobOnboardingData({
    this.id,
    this.interviewer,
    this.joiningDate,
    this.daysOfWeek,
    this.salary,
    this.currency,
    this.salaryType,
    this.salaryDuration,
    this.jobType,
    this.status,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  JobOnboardingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interviewer = json['Interviewer'];
    joiningDate = json['JoiningDate'];
    daysOfWeek = json['DaysOfWeek'];
    salary = json['Salary'];
    currency = json['Currency'];
    salaryType = json['SalaryType'];
    salaryDuration = json['SalaryDuration'];
    jobType = json['JobType'];
    status = json['Status'];
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
    map['Interviewer'] = interviewer;
    map['JoiningDate'] = joiningDate;
    map['DaysOfWeek'] = daysOfWeek;
    map['Salary'] = salary;
    map['Currency'] = currency;
    map['SalaryType'] = salaryType;
    map['SalaryDuration'] = salaryDuration;
    map['JobType'] = jobType;
    map['Status'] = status;
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
