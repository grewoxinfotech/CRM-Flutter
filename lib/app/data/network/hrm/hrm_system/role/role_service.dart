import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'role_model.dart';

class RoleService {
  final String baseUrl = UrlRes.roles; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch roles with optional pagination & search
  Future<RoleModel?> fetchRoles({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return RoleModel.fromJson(data);
      } else {
        print("Failed to load roles: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchRoles: $e");
    }
    return null;
  }

  /// Get single role by ID
  Future<RoleData?> getRoleById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RoleData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get role by ID exception: $e");
    }
    return null;
  }

  /// Create new role
  Future<bool> createRole(RoleData role) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${role.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(role.toJson()),
      );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create role exception: $e");
      return false;
    }
  }

  /// Update role
  Future<bool> updateRole(String id, RoleData role) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(role.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update role exception: $e");
      return false;
    }
  }

  /// Delete role
  Future<bool> deleteRole(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete role exception: $e");
      return false;
    }
  }
}
