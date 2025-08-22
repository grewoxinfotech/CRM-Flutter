import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../../care/constants/database_res.dart';
import '../../network/hrm/hrm_system/role/role_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  /// Get database instance
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  /// Initialize database
  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'roles.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBConstants.rolesTable} (
        ${DBConstants.colRoleId} TEXT PRIMARY KEY,
        ${DBConstants.colRoleName} TEXT,
        ${DBConstants.colClientId} TEXT,
        ${DBConstants.colCreatedBy} TEXT,
        ${DBConstants.colUpdatedBy} TEXT,
        ${DBConstants.colCreatedAt} TEXT,
        ${DBConstants.colUpdatedAt} TEXT,
        ${DBConstants.colKey} TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE ${DBConstants.roleModulesTable} (
        ${DBConstants.colModuleId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConstants.colModuleRoleId} TEXT,
        ${DBConstants.colModuleKey} TEXT,
        FOREIGN KEY(${DBConstants.colModuleRoleId}) REFERENCES ${DBConstants.rolesTable}(${DBConstants.colRoleId}) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE ${DBConstants.modulePermissionsTable} (
        ${DBConstants.colPermissionId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConstants.colPermissionModuleId} INTEGER,
        ${DBConstants.colPermissionKey} TEXT,
        ${DBConstants.colPermission} TEXT,
        FOREIGN KEY(${DBConstants.colPermissionModuleId}) REFERENCES ${DBConstants.roleModulesTable}(${DBConstants.colModuleId}) ON DELETE CASCADE
      );
    ''');
  }

  /// Insert or update a single role along with its modules and permissions
  // Future<void> insertRole(RoleData role, {DatabaseExecutor? txn}) async {
  //   final dbExecutor = txn ?? await database;
  //
  //   await dbExecutor.transaction((transaction) async {
  //     // Insert role
  //     await transaction.insert(DBConstants.rolesTable, {
  //       DBConstants.colRoleId: role.id,
  //       DBConstants.colRoleName: role.roleName,
  //       DBConstants.colClientId: role.clientId,
  //       DBConstants.colCreatedBy: role.createdBy,
  //       DBConstants.colUpdatedBy: role.updatedBy,
  //       DBConstants.colCreatedAt: role.createdAt,
  //       DBConstants.colUpdatedAt: role.updatedAt,
  //       DBConstants.colKey: role.key,
  //     }, conflictAlgorithm: ConflictAlgorithm.replace);
  //
  //     // Remove old modules & permissions
  //     final oldModules = await transaction.query(
  //       DBConstants.roleModulesTable,
  //       where: '${DBConstants.colModuleRoleId} = ?',
  //       whereArgs: [role.id],
  //     );
  //
  //     for (var module in oldModules) {
  //       await transaction.delete(
  //         DBConstants.modulePermissionsTable,
  //         where: '${DBConstants.colPermissionModuleId} = ?',
  //         whereArgs: [module[DBConstants.colModuleId]],
  //       );
  //     }
  //
  //     await transaction.delete(
  //       DBConstants.roleModulesTable,
  //       where: '${DBConstants.colModuleRoleId} = ?',
  //       whereArgs: [role.id],
  //     );
  //
  //     // Insert new modules & permissions
  //     if (role.permissions != null) {
  //       for (final entry in role.permissions!.entries) {
  //         final moduleKey = entry.key;
  //         final permissionItems = entry.value;
  //
  //         final moduleId = await transaction
  //             .insert(DBConstants.roleModulesTable, {
  //               DBConstants.colModuleRoleId: role.id,
  //               DBConstants.colModuleKey: moduleKey,
  //             });
  //
  //         for (final item in permissionItems) {
  //           if (item.permissions != null) {
  //             for (final perm in item.permissions!) {
  //               await transaction.insert(DBConstants.modulePermissionsTable, {
  //                 DBConstants.colPermissionModuleId: moduleId,
  //                 DBConstants.colPermissionKey: item.key,
  //                 DBConstants.colPermission: perm,
  //               });
  //             }
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  Future<void> insertRole(RoleData role, {Transaction? txn}) async {
    final dbExecutor = txn ?? await database; // Database or Transaction

    // Insert role
    await dbExecutor.insert(DBConstants.rolesTable, {
      DBConstants.colRoleId: role.id,
      DBConstants.colRoleName: role.roleName,
      DBConstants.colClientId: role.clientId,
      DBConstants.colCreatedBy: role.createdBy,
      DBConstants.colUpdatedBy: role.updatedBy,
      DBConstants.colCreatedAt: role.createdAt,
      DBConstants.colUpdatedAt: role.updatedAt,
      DBConstants.colKey: role.key,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    // Remove old modules & permissions
    final oldModules = await dbExecutor.query(
      DBConstants.roleModulesTable,
      where: '${DBConstants.colModuleRoleId} = ?',
      whereArgs: [role.id],
    );

    for (var module in oldModules) {
      await dbExecutor.delete(
        DBConstants.modulePermissionsTable,
        where: '${DBConstants.colPermissionModuleId} = ?',
        whereArgs: [module[DBConstants.colModuleId]],
      );
    }

    await dbExecutor.delete(
      DBConstants.roleModulesTable,
      where: '${DBConstants.colModuleRoleId} = ?',
      whereArgs: [role.id],
    );

    // Insert new modules & permissions
    if (role.permissions != null) {
      for (final entry in role.permissions!.entries) {
        final moduleKey = entry.key;
        final permissionItems = entry.value;

        final moduleId = await dbExecutor.insert(DBConstants.roleModulesTable, {
          DBConstants.colModuleRoleId: role.id,
          DBConstants.colModuleKey: moduleKey,
        });

        for (final item in permissionItems) {
          if (item.permissions != null) {
            for (final perm in item.permissions!) {
              await dbExecutor.insert(DBConstants.modulePermissionsTable, {
                DBConstants.colPermissionModuleId: moduleId,
                DBConstants.colPermission: perm,
              });
            }
          }
        }
      }
    }
  }

  /// Insert multiple roles safely
  Future<void> insertAllRoles(List<RoleData> roles) async {
    for (var role in roles) {
      await insertRole(role);
    }
  }

  /// Sync roles from API: clear old data and insert fresh
  Future<void> syncRolesFromAPI(List<RoleData> roles) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(DBConstants.modulePermissionsTable);
      await txn.delete(DBConstants.roleModulesTable);
      await txn.delete(DBConstants.rolesTable);

      for (var role in roles) {
        await insertRole(role, txn: txn);
      }
    });
  }

  /// Fetch all roles as List<RoleData>
  Future<List<RoleData>> getAllRoles() async {
    final db = await database;
    final rolesMap = await db.query(DBConstants.rolesTable);
    List<RoleData> roles = [];

    for (var roleMap in rolesMap) {
      final modules = await db.query(
        DBConstants.roleModulesTable,
        where: '${DBConstants.colModuleRoleId} = ?',
        whereArgs: [roleMap[DBConstants.colRoleId]],
      );

      Map<String, List<PermissionItem>> permMap = {};

      for (var module in modules) {
        final perms = await db.query(
          DBConstants.modulePermissionsTable,
          where: '${DBConstants.colPermissionModuleId} = ?',
          whereArgs: [module[DBConstants.colModuleId]],
        );

        List<PermissionItem> permissionItems = [];

        for (var perm in perms) {
          final existing = permissionItems.firstWhere(
            (e) => e.key == perm[DBConstants.colPermissionKey],
            orElse:
                () => PermissionItem(
                  key: perm[DBConstants.colPermissionKey] as String?,
                  permissions: [],
                ),
          );

          existing.permissions?.add(perm[DBConstants.colPermission] as String);

          if (!permissionItems.contains(existing))
            permissionItems.add(existing);
        }

        permMap[module[DBConstants.colModuleKey] as String] = permissionItems;
      }

      roles.add(
        RoleData(
          id: roleMap[DBConstants.colRoleId] as String?,
          roleName: roleMap[DBConstants.colRoleName] as String?,
          clientId: roleMap[DBConstants.colClientId] as String?,
          createdBy: roleMap[DBConstants.colCreatedBy] as String?,
          updatedBy: roleMap[DBConstants.colUpdatedBy] as String?,
          createdAt: roleMap[DBConstants.colCreatedAt] as String?,
          updatedAt: roleMap[DBConstants.colUpdatedAt] as String?,
          key: roleMap[DBConstants.colKey] as String?,
          permissions: permMap.isEmpty ? null : permMap,
        ),
      );
    }

    return roles;
  }

  /// Fetch a specific role by ID
  Future<RoleData?> getRoleById(String roleId) async {
    final db = await database;
    final rolesMap = await db.query(
      DBConstants.rolesTable,
      where: '${DBConstants.colRoleId} = ?',
      whereArgs: [roleId],
      limit: 1,
    );

    if (rolesMap.isEmpty) return null;
    final roleMap = rolesMap.first;

    final modules = await db.query(
      DBConstants.roleModulesTable,
      where: '${DBConstants.colModuleRoleId} = ?',
      whereArgs: [roleId],
    );

    Map<String, List<PermissionItem>> permMap = {};

    for (var module in modules) {
      final perms = await db.query(
        DBConstants.modulePermissionsTable,
        where: '${DBConstants.colPermissionModuleId} = ?',
        whereArgs: [module[DBConstants.colModuleId]],
      );

      List<PermissionItem> permissionItems = [];

      for (var perm in perms) {
        final existing = permissionItems.firstWhere(
          (e) => e.key == perm[DBConstants.colPermissionKey],
          orElse:
              () => PermissionItem(
                key: perm[DBConstants.colPermissionKey] as String?,
                permissions: [],
              ),
        );

        existing.permissions?.add(perm[DBConstants.colPermission] as String);

        if (!permissionItems.contains(existing)) permissionItems.add(existing);
      }

      permMap[module[DBConstants.colModuleKey] as String] = permissionItems;
    }
    print(
      "[DEBUG]=>PermMap : ${permMap.map((key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()))}",
    );

    return RoleData(
      id: roleMap[DBConstants.colRoleId] as String?,
      roleName: roleMap[DBConstants.colRoleName] as String?,
      clientId: roleMap[DBConstants.colClientId] as String?,
      createdBy: roleMap[DBConstants.colCreatedBy] as String?,
      updatedBy: roleMap[DBConstants.colUpdatedBy] as String?,
      createdAt: roleMap[DBConstants.colCreatedAt] as String?,
      updatedAt: roleMap[DBConstants.colUpdatedAt] as String?,
      key: roleMap[DBConstants.colKey] as String?,
      permissions: permMap.isEmpty ? null : permMap,
    );
  }

  /// Check if a role has a specific permission for a module
  Future<bool> hasPermission(
    String roleId,
    String moduleKey,
    String permission,
  ) async {
    final db = await database;
    final result = await db.rawQuery(
      '''
      SELECT 1 
      FROM ${DBConstants.modulePermissionsTable} mp
      JOIN ${DBConstants.roleModulesTable} rm 
      ON mp.${DBConstants.colPermissionModuleId} = rm.${DBConstants.colModuleId}
      WHERE rm.${DBConstants.colModuleRoleId} = ? 
      AND rm.${DBConstants.colModuleKey} = ? 
      AND mp.${DBConstants.colPermission} = ?
    ''',
      [roleId, moduleKey, permission],
    );

    return result.isNotEmpty;
  }
}
