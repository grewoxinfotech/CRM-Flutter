class RoleModel {
  bool? success;
  RoleMessage? message;
  dynamic data;

  RoleModel({this.success, this.message, this.data});

  RoleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
    json['message'] != null ? RoleMessage.fromJson(json['message']) : null;
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

class RoleMessage {
  List<RoleData>? data;
  Pagination? pagination;

  RoleMessage({this.data, this.pagination});

  RoleMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<RoleData>.from(json['data'].map((x) => RoleData.fromJson(x)));
    }
    pagination =
    json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
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

class RoleData {
  String? id;
  String? roleName;
  Map<String, List<PermissionItem>>? permissions;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  RoleData({
    this.id,
    this.roleName,
    this.permissions,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  RoleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];

    if (json['permissions'] != null) {
      permissions = {};
      json['permissions'].forEach((k, v) {
        permissions![k] =
        List<PermissionItem>.from(v.map((x) => PermissionItem.fromJson(x)));
      });
    }

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
    map['role_name'] = roleName;

    if (permissions != null) {
      final permMap = <String, dynamic>{};
      permissions!.forEach((k, v) {
        permMap[k] = v.map((e) => e.toJson()).toList();
      });
      map['permissions'] = permMap;
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

class PermissionItem {
  String? key;
  List<String>? permissions;

  PermissionItem({this.key, this.permissions});

  PermissionItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    permissions = json['permissions'] != null
        ? List<String>.from(json['permissions'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['key'] = key;
    map['permissions'] = permissions;
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
