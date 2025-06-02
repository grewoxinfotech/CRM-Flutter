class RoleModel {
  final String id;
  final String roleName;
  final Map<String, List<ModulePermission>>? permissions;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;

  RoleModel({
    required this.id,
    required this.roleName,
    required this.permissions,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] ?? '',
      roleName: json['role_name'] ?? '',
      permissions: json['permissions'] != null
          ? (json['permissions'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((e) => ModulePermission.fromJson(e))
              .toList(),
        ),
      )
          : null,
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role_name": roleName,
      "permissions": permissions?.map((key, value) => MapEntry(
        key,
        value.map((e) => e.toJson()).toList(),
      )),
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "key": key,
    };
  }
}

class ModulePermission {
  final String key;
  final List<String> permissions;

  ModulePermission({
    required this.key,
    required this.permissions,
  });

  factory ModulePermission.fromJson(Map<String, dynamic> json) {
    return ModulePermission(
      key: json['key'] ?? '',
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "permissions": permissions,
    };
  }
}
