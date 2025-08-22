class DBConstants {
  // Tables
  static const String rolesTable = 'roles';
  static const String roleModulesTable = 'role_modules';
  static const String modulePermissionsTable = 'module_permissions';

  // Roles Table Columns
  static const String colRoleId = 'id';
  static const String colRoleName = 'role_name';
  static const String colClientId = 'client_id';
  static const String colCreatedBy = 'created_by';
  static const String colUpdatedBy = 'updated_by';
  static const String colCreatedAt = 'created_at';
  static const String colUpdatedAt = 'updated_at';
  static const String colKey = 'key';

  // Role Modules Table Columns
  static const String colModuleId = 'id';
  static const String colModuleRoleId = 'role_id';
  static const String colModuleKey = 'module_key';

  // Module Permissions Table Columns
  static const String colPermissionId = 'id';
  static const String colPermissionModuleId = 'module_id';
  static const String colPermissionKey =
      'permission_key'; // NEW: store PermissionItem.key
  static const String colPermission = 'permission';
}
