import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/hrm/leave/leave/leave_model.dart';
import 'package:http/http.dart' as http;


class LeaveService {
  final String baseUrl = UrlRes.leaves; // Define in UrlRes
  final String approve = UrlRes.approveLeaves;

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch leaves with optional pagination & search
  Future<LeaveModel?> fetchLeaves({
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

        return LeaveModel.fromJson(data);
      } else {
        print("Failed to load leaves: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchLeaves: $e");
    }
    return null;
  }

  /// Get single leave by ID
  Future<LeaveData?> getLeaveById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LeaveData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get leave by ID exception: $e");
    }
    return null;
  }

  /// Create new leave
  Future<bool> createLeave(LeaveData leave) async {
    try {
      print("=> $baseUrl ---- ${leave.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(leave.toJson()),
      );
      print("=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create leave exception: $e");
      return false;
    }
  }

  Future<bool> approveLeave(LeaveData leave) async {
    try {
      final url = "$approve/${leave.id}";
      print("=> $baseUrl ---- ${url}");

      final response = await http.put(
        Uri.parse(url),
        headers: await headers(),
        body: jsonEncode(leave.toJson()),
      );
      print("=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create leave exception: $e");
      return false;
    }
  }

  /// Update leave
  Future<bool> updateLeave(String id, LeaveData leave) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(leave.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update leave exception: $e");
      return false;
    }
  }

  /// Delete leave
  Future<bool> deleteLeave(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete leave exception: $e");
      return false;
    }
  }
}
