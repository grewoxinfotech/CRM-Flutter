class InquiryModel {
  bool? success;
  String? message;
  List<InquiryData>? data;

  InquiryModel({this.success, this.message, this.data});

  InquiryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<InquiryData>.from(
        json['data'].map((x) => InquiryData.fromJson(x)),
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

class InquiryData {
  String? id;
  String? name;
  String? email;
  String? phonecode;
  String? phone;
  String? subject;
  String? message;
  String? clientId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  InquiryData({
    this.id,
    this.name,
    this.email,
    this.phonecode,
    this.phone,
    this.subject,
    this.message,
    this.clientId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  InquiryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phonecode = json['phonecode'];
    phone = json['phone'];
    subject = json['subject'];
    message = json['message'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phonecode'] = phonecode;
    map['phone'] = phone;
    map['subject'] = subject;
    map['message'] = message;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
