import 'dart:convert';
import 'package:crm_flutter/app/data/network/all/hrm/role/model/roles_model.dart';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:get/get.dart';

class RolesService extends GetxService {
  final String url = UrlRes.roles;
  final RxList<RoleModel> roles = <RoleModel>[].obs;

  Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List<RoleModel>> getRoles() async {
    try {
      final response = await http.get(
        Uri.parse('$url?client_id=true'),
        headers: await headers(),
      );

      final responseData = jsonDecode(response.body); 
      
      if (response.statusCode == 200 && responseData['success'] == true) {
        final List<dynamic> data = responseData['data'];
        final rolesList = data.map((json) => RoleModel.fromJson(json)).toList();
        roles.assignAll(rolesList);
        return rolesList;
      } else {
        throw Exception(responseData['message'] ?? 'Failed to load roles');
      } 
    } catch (e) {
      print('Error in getRoles: $e');
      roles.clear();
      throw Exception('Failed to load roles: $e');
    }
  }

  // Helper method to get role name by ID
  String getRoleNameById(String roleId) {
    try {
      final role = roles.firstWhere((role) => role.id == roleId);
      return role.roleName;
    } catch (e) {
      return 'Unknown Role';
    }
  }

  // Helper method to check if a role has specific permission
  bool hasPermission(String roleId, String permissionKey, String permissionType) {
    try {
      final role = roles.firstWhere((role) => role.id == roleId);
      final permissionList = role.permissions[permissionKey];
      if (permissionList == null) return false;
      
      return permissionList.any((permission) => 
        permission.permissions.contains(permissionType));
    } catch (e) {
      return false;
    }
  }
}
          
