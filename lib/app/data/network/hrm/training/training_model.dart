// import 'dart:convert';
//
// class TrainingModel {
//   final String id;
//   final String title;
//   final String category;
//   final Map<String, dynamic> links; // Links will be a JSON object
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   TrainingModel({
//     required this.id,
//     required this.title,
//     required this.category,
//     required this.links,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory TrainingModel.fromJson(Map<String, dynamic> json) {
//     return TrainingModel(
//       id: json['id'],
//       title: json['title'],
//       category: json['category'],
//       links: jsonDecode(json['links']), // Decoding the links JSON string
//       clientId: json['client_id'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'category': category,
//       'links': jsonEncode(links), // Encoding the links JSON object
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

class TrainingModel {
  bool? success;
  TrainingMessage? message;
  dynamic data;

  TrainingModel({this.success, this.message, this.data});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? TrainingMessage.fromJson(json['message'])
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

class TrainingMessage {
  List<TrainingData>? data;
  Pagination? pagination;

  TrainingMessage({this.data, this.pagination});

  TrainingMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<TrainingData>.from(
        json['data'].map((x) => TrainingData.fromJson(x)),
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

class TrainingData {
  String? id;
  String? title;
  String? category;
  TrainingLinks? links;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  TrainingData({
    this.id,
    this.title,
    this.category,
    this.links,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  TrainingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    links =
        json['links'] != null ? TrainingLinks.fromJson(json['links']) : null;
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
    if (links != null) {
      map['links'] = links!.toJson();
    }
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
  }
}

class TrainingLinks {
  List<String>? urls;
  List<String>? titles;

  TrainingLinks({this.urls, this.titles});

  TrainingLinks.fromJson(Map<String, dynamic> json) {
    urls = json['urls'] != null ? List<String>.from(json['urls']) : [];
    titles = json['titles'] != null ? List<String>.from(json['titles']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (urls != null) {
      map['urls'] = urls;
    }
    if (titles != null) {
      map['titles'] = titles;
    }
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
