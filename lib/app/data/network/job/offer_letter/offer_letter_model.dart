class OfferLetterModel {
  bool? success;
  OfferLetterMessage? message;
  dynamic data;

  OfferLetterModel({this.success, this.message, this.data});

  OfferLetterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] != null
        ? OfferLetterMessage.fromJson(json['message'])
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

class OfferLetterMessage {
  List<OfferLetterData>? data;
  Pagination? pagination;

  OfferLetterMessage({this.data, this.pagination});

  OfferLetterMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<OfferLetterData>.from(
        json['data'].map((x) => OfferLetterData.fromJson(x)),
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

class OfferLetterData {
  String? id;
  String? job;
  String? jobApplicant;
  String? currency;
  String? offerExpiry;
  String? expectedJoiningDate;
  String? salary;
  String? description;
  String? file;
  String? status;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  OfferLetterData({
    this.id,
    this.job,
    this.jobApplicant,
    this.currency,
    this.offerExpiry,
    this.expectedJoiningDate,
    this.salary,
    this.description,
    this.file,
    this.status,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  OfferLetterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'];
    jobApplicant = json['job_applicant'];
    currency = json['currency'];
    offerExpiry = json['offer_expiry'];
    expectedJoiningDate = json['expected_joining_date'];
    salary = json['salary'];
    description = json['description'];
    file = json['file'];
    status = json['status'];
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
    map['job_applicant'] = jobApplicant;
    map['currency'] = currency;
    map['offer_expiry'] = offerExpiry;
    map['expected_joining_date'] = expectedJoiningDate;
    map['salary'] = salary;
    map['description'] = description;
    map['file'] = file;
    map['status'] = status;
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
