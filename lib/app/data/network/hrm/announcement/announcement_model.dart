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
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'updated_by': updatedBy,
    'title': title,
    'description': description,
    'branch': branch?.toJson(),
    'time': time,
    'date': date,
    'section': section,
    'client_id': clientId,
    'created_by': createdBy,
    'updatedAt': updatedAt,
    'createdAt': createdAt,
  };
}

class Branch {
  List<String>? branch;

  Branch({this.branch});

  Branch.fromJson(Map<String, dynamic> json) {
    branch = json['branch'] != null ? List<String>.from(json['branch']) : null;
  }

  Map<String, dynamic> toJson() => {'branch': branch};
}

class AnnouncementModel {
  bool? success;
  AnnouncementMessage? message;
  dynamic data;

  AnnouncementModel({this.success, this.message, this.data});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? AnnouncementMessage.fromJson(json['message'])
            : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message?.toJson(),
    'data': data,
  };
}

class AnnouncementMessage {
  List<AnnouncementData>? data;

  AnnouncementMessage({this.data});

  AnnouncementMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<AnnouncementData>.from(
        (json['data'] as List).map((x) => AnnouncementData.fromJson(x)),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((v) => v.toJson()).toList(),
  };
}
