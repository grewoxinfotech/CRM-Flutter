import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import 'designation_model.dart';

class DesignationService {
  final String baseUrl = UrlRes.designations; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch designations with optional pagination & search
  Future<DesignationModel?> fetchDesignations({
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
        return DesignationModel.fromJson(data);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to load designations (${response.statusCode})",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Exception in fetchDesignations: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching designations",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Get single designation by ID
  Future<DesignationData?> getDesignationById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DesignationData.fromJson(data["message"]["data"]);
      } else {}
    } catch (e) {
      print("Get designation by ID exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching designation",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Create new designation
  Future<bool> createDesignation(DesignationData designation) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(designation.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message:
              responseData["message"] ?? "Designation created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create designation",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create designation exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while creating designation",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Update designation
  Future<bool> updateDesignation(String id, DesignationData designation) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(designation.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message:
              responseData["message"] ?? "Designation updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update designation",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update designation exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating designation",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete designation
  Future<bool> deleteDesignation(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Designation deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to delete designation",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Delete designation exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while deleting designation",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
