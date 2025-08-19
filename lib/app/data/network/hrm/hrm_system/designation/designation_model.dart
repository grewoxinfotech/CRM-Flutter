// class DesignationModel {
//   final String id;
//   final String branch;
//   final String designationName;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   DesignationModel({
//     required this.id,
//     required this.branch,
//     required this.designationName,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory DesignationModel.fromJson(Map<String, dynamic> json) {
//     return DesignationModel(
//       id: json['id'],
//       branch: json['branch'],
//       designationName: json['designation_name'],
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
//       'branch': branch,
//       'designation_name': designationName,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

class DesignationModel {
  bool? success;
  DesignationMessage? message;
  dynamic data;

  DesignationModel({this.success, this.message, this.data});

  DesignationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? DesignationMessage.fromJson(json['message'])
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

class DesignationMessage {
  List<DesignationData>? data;
  Pagination? pagination;

  DesignationMessage({this.data, this.pagination});

  DesignationMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<DesignationData>.from(
        json['data'].map((x) => DesignationData.fromJson(x)),
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

class DesignationData {
  String? id;
  String? branch;
  String? designationName;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  DesignationData({
    this.id,
    this.branch,
    this.designationName,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  DesignationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branch = json['branch'];
    designationName = json['designation_name'];
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
    map['branch'] = branch;
    map['designation_name'] = designationName;
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
