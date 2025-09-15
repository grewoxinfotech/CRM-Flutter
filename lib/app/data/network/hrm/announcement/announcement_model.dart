class AnnouncementModel {
  bool? success;
  AnnouncementMessage? message;
  dynamic data;

  AnnouncementModel({this.success, this.message, this.data});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'] != null
        ? AnnouncementMessage.fromJson(json['message'])
        : null;
    data = json['message']?['data']; // consistent with BranchModel
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

class AnnouncementMessage {
  List<AnnouncementData>? data;
  Pagination? pagination;

  AnnouncementMessage({this.data, this.pagination});

  AnnouncementMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<AnnouncementData>.from(
        (json['data'] as List).map((x) => AnnouncementData.fromJson(x)),
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

class AnnouncementData {
  String? id;
  String? updatedBy;
  String? title;
  String? description;
  Branch? branch;
  String? time;
  String? date;
  String? section;
  String? clientId;
  String? createdBy;
  String? updatedAt;
  String? createdAt;

  AnnouncementData({
    this.id,
    this.updatedBy,
    this.title,
    this.description,
    this.branch,
    this.time,
    this.date,
    this.section,
    this.clientId,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
  });

  AnnouncementData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedBy = json['updated_by'];
    title = json['title'];
    description = json['description'];
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    time = json['time'];
    date = json['date'];
    section = json['section']; // ✅ added missing section
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['updated_by'] = updatedBy;
    map['title'] = title;
    map['description'] = description;
    map['branch'] = branch?.toJson();
    map['time'] = time;
    map['date'] = date;
    map['section'] = section;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updatedAt'] = updatedAt;
    map['createdAt'] = createdAt;
    return map;
  }
}

class Branch {
  List<String>? branch;

  Branch({this.branch});

  Branch.fromJson(Map<String, dynamic> json) {
    branch = json['branch'] != null ? List<String>.from(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['branch'] = branch;
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
