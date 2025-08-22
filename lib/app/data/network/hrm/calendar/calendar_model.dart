class CalendarModel {
  bool? success;
  String? message;
  List<CalendarData>? data;

  CalendarModel({this.success, this.message, this.data});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<CalendarData>.from(
        json['data'].map((x) => CalendarData.fromJson(x)),
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

class CalendarData {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? label;
  String? color;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  CalendarData({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.label,
    this.color,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  CalendarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    label = json['label'];
    color = json['color'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['label'] = label;
    map['color'] = color;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
