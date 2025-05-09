import 'dart:convert';

class RoleModel {
  final String id;
  final String roleName;
  final Map<String, List<Permission>> permissions;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoleModel({
    required this.id,
    required this.roleName,
    required this.permissions,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    // Parse permissions
    Map<String, List<Permission>> parsedPermissions = {};
    if (json['permissions'] != null) {
      (json['permissions'] as Map<String, dynamic>).forEach((key, value) {
        if (value is List) {
          parsedPermissions[key] = value
              .map((item) => Permission.fromJson(item))
              .toList();
        }
      });
    }

    return RoleModel(
      id: json['id'] ?? '',
      roleName: json['role_name'] ?? '',
      permissions: parsedPermissions,
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    // Convert permissions back to JSON format
    Map<String, dynamic> permissionsJson = {};
    permissions.forEach((key, value) {
      permissionsJson[key] = value.map((p) => p.toJson()).toList();
    });

    return {
      'id': id,
      'role_name': roleName,
      'permissions': permissionsJson,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Permission {
  final String key;
  final List<String> permissions;

  Permission({
    required this.key,
    required this.permissions,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      key: json['key'] ?? '',
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'permissions': permissions,
    };
  }
}
