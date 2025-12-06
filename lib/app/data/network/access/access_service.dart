import '../hrm/hrm_system/role/role_model.dart';

class AccessService {
  final Map<String, List<String>> _permissions = {};

  AccessService(Map<String, dynamic> perms) {
    _parsePermissions(perms);
  }

  void _parsePermissions(Map<String, dynamic> perms) {
    perms.forEach((module, permList) {
      List<String> actions = [];

      if (permList is List) {
        for (var item in permList) {
          // Accept any map-like object
          if (item is Map) {
            final permsList = item['permissions'];
            if (permsList is List) {
              actions.addAll(permsList.map((e) => e.toString()));
            }
          }
          // Optional: handle PermissionItem if used
          else if (item is PermissionItem) {
            if (item.permissions != null) {
              actions.addAll(item.permissions!.map((e) => e.toString()));
            }
          }
        }
      }

      _permissions[module] = actions.toSet().toList();
    });
  }

  bool can(String module, String action) {
    if (!_permissions.containsKey(module)) return false;
    return _permissions[module]!.contains(action);
  }

  List<String> allowedActions(String module) {
    return _permissions[module] ?? [];
  }

  Map<String, List<String>> get allPermissions => _permissions;
}
