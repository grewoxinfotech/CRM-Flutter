// class BranchModel {
//   final String id;
//   final String branchName;
//   final String branchAddress;
//   final String branchManager;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   BranchModel({
//     required this.id,
//     required this.branchName,
//     required this.branchAddress,
//     required this.branchManager,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory BranchModel.fromJson(Map<String, dynamic> json) {
//     return BranchModel(
//       id: json['id'],
//       branchName: json['branchName'],
//       branchAddress: json['branchAddress'],
//       branchManager: json['branchManager'],
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
//       'branchName': branchName,
//       'branchAddress': branchAddress,
//       'branchManager': branchManager,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

class BranchModel {
  bool? success;
  BranchMessage? message;
  dynamic data;

  BranchModel({this.success, this.message, this.data});

  BranchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? BranchMessage.fromJson(json['message'])
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

class BranchMessage {
  List<BranchData>? data;
  Pagination? pagination;

  BranchMessage({this.data, this.pagination});

  BranchMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<BranchData>.from(
        json['data'].map((x) => BranchData.fromJson(x)),
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

class BranchData {
  String? id;
  String? branchName;
  String? branchAddress;
  String? branchManager;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  BranchData({
    this.id,
    this.branchName,
    this.branchAddress,
    this.branchManager,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  BranchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    branchManager = json['branchManager'];
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
    map['branchName'] = branchName;
    map['branchAddress'] = branchAddress;
    map['branchManager'] = branchManager;
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
