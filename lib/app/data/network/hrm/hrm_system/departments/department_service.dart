import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'department_model.dart';

class DepartmentService {
  final String baseUrl = UrlRes.departments; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch departments with optional pagination & search
  Future<List<DepartmentData>> fetchDepartments({
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

      final token = await headers();
      print("[DEBUG]=>Token: ${token}");
      final response = await http.get(uri, headers: token);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> departments = data["message"]["data"];
        return departments
            .map((json) => DepartmentData.fromJson(json))
            .toList();
      } else {
        print("Failed to load departments: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchDepartments: $e");
    }
    return [];
  }

  /// Get single department by ID
  Future<DepartmentData?> getDepartmentById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DepartmentData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get department by ID exception: $e");
    }
    return null;
  }

  /// Create new department
  Future<bool> createDepartment(DepartmentData department) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${department.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(department.toJson()),
      );
      print("[DEBUG]=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create department exception: $e");
      return false;
    }
  }

  /// Update department
  Future<bool> updateDepartment(String id, DepartmentData department) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(department.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update department exception: $e");
      return false;
    }
  }

  /// Delete department
  Future<bool> deleteDepartment(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete department exception: $e");
      return false;
    }
  }
}
