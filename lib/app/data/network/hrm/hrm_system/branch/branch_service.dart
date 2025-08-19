import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'branch_model.dart';

class BranchService {
  final String baseUrl = UrlRes.branches; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch branches with optional pagination & search
  Future<List<BranchData>> fetchBranches({
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
        final List<dynamic> branches = data["message"]["data"];
        return branches.map((json) => BranchData.fromJson(json)).toList();
      } else {
        print("Failed to load branches: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchBranches: $e");
    }
    return [];
  }

  /// Get single branch by ID
  Future<BranchData?> getBranchById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BranchData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get branch by ID exception: $e");
    }
    return null;
  }

  /// Create new branch
  Future<bool> createBranch(BranchData branch) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${branch.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(branch.toJson()),
      );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create branch exception: $e");
      return false;
    }
  }

  /// Update branch
  Future<bool> updateBranch(String id, BranchData branch) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(branch.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update branch exception: $e");
      return false;
    }
  }

  /// Delete branch
  Future<bool> deleteBranch(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete branch exception: $e");
      return false;
    }
  }
}
