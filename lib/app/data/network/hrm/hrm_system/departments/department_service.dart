import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import 'department_model.dart';

class DepartmentService {
  final String baseUrl = UrlRes.departments; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch departments with optional pagination & search
  Future<DepartmentModel?> fetchDepartments({
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
        return DepartmentModel.fromJson(data);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to load departments (${response.statusCode})",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Exception in fetchDepartments: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching departments",
        contentType: ContentType.failure,
      );
    }
    return null;
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
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to fetch department details",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Get department by ID exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching department details",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Create new department
  Future<bool> createDepartment(DepartmentData department) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(department.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Department created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create department",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create department exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while creating department",
        contentType: ContentType.failure,
      );
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Department updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update department",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update department exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating department",
        contentType: ContentType.failure,
      );
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

      if (response.statusCode == 200 || response.statusCode == 204) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Department deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to delete department",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Delete department exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while deleting department",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
