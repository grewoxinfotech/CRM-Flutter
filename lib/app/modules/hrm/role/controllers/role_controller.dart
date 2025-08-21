import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/role/role_model.dart';
import '../../../../data/network/hrm/hrm_system/role/role_service.dart';

class RolesController extends PaginatedController<RoleData> {
  final RoleService _service = RoleService();
  final String url = UrlRes.roles;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController roleNameController = TextEditingController();

  /// Permissions map (key -> permissions list)
  RxMap<String, List<String>> permissions = <String, List<String>>{}.obs;

  @override
  Future<List<RoleData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchRoles(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  void resetForm() {
    roleNameController.clear();
    permissions.clear();
  }

  /// Get single role by ID
  Future<RoleData?> getRoleById(String id) async {
    try {
      final existingRole = items.firstWhereOrNull((item) => item.id == id);
      if (existingRole != null) {
        return existingRole;
      } else {
        final role = await _service.getRoleById(id);
        if (role != null) {
          items.add(role);
          items.refresh();
          return role;
        }
      }
    } catch (e) {
      print("Get role error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createRole(RoleData role) async {
    try {
      final success = await _service.createRole(role);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create role error: $e");
      return false;
    }
  }

  Future<bool> updateRole(String id, RoleData updatedRole) async {
    try {
      final success = await _service.updateRole(id, updatedRole);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedRole;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update role error: $e");
      return false;
    }
  }

  Future<bool> deleteRole(String id) async {
    try {
      final success = await _service.deleteRole(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete role error: $e");
      return false;
    }
  }
}
