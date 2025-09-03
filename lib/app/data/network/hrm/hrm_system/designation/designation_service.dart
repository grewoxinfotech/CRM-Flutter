import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'designation_model.dart';

class DesignationService {
  final String baseUrl = UrlRes.designations; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch designations with optional pagination & search
  Future<List<DesignationData>> fetchDesignations({
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
        final List<dynamic> designations = data["message"]["data"];
        return designations
            .map((json) => DesignationData.fromJson(json))
            .toList();
      } else {
        print("Failed to load designations: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchDesignations: $e");
    }
    return [];
  }

  /// Get single designation by ID
  Future<DesignationData?> getDesignationById(String id) async {
    try {
      print("Get designation by ID: $id");
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Get designation by ID response: $data");
        return DesignationData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get designation by ID exception: $e");
    }
    return null;
  }

  /// Create new designation
  Future<bool> createDesignation(DesignationData designation) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${designation.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(designation.toJson()),
      );
      print("[DEBUG]=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create designation exception: $e");
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
      return response.statusCode == 200;
    } catch (e) {
      print("Update designation exception: $e");
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
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete designation exception: $e");
      return false;
    }
  }
}
