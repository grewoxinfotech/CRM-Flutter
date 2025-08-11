import 'dart:convert';
import 'package:crm_flutter/app/data/network/user/role/model/roles_model.dart';
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
        List<dynamic>? data;
        
        // Check if data is in the new structure (nested under message.data)
        if (responseData["message"] != null && responseData["message"]["data"] != null) {
          data = responseData["message"]["data"];
        } else {
          // Fallback to old structure
          data = responseData['data'];
        }
        
        if (data == null) {
          roles.clear();
          return [];
        }
        
        final rolesList = data.map((json) => RoleModel.fromJson(json)).toList();
        roles.assignAll(rolesList);
        return rolesList;
      } else {
        roles.clear();
        return [];
      } 
    } catch (e) {
      roles.clear();
      return [];
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
          
