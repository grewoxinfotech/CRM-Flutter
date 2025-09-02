import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'attendance_model.dart';

class AttendanceService {
  final String baseUrl = UrlRes.attendance; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch attendance list with optional pagination & search
  Future<List<AttendanceData>> fetchAttendance({
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
        final List<dynamic> attendances = data["data"];
        return attendances
            .map((json) => AttendanceData.fromJson(json))
            .toList();
      } else {
        print("Failed to load attendance: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchAttendance: $e");
    }
    return [];
  }

  /// Get single attendance by ID
  Future<AttendanceData?> getAttendanceById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      print("Get attendance by ID: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Map<String, dynamic> result = data["data"];
        print("Get attendance by ID: $result");
        return AttendanceData.fromJson(result);
      }
    } catch (e) {
      print("Get attendance by ID exception: $e");
    }
    return null;
  }

  /// Create new attendance record
  Future<AttendanceData> createAttendance(AttendanceData attendance) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${attendance.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(attendance.toJson()),
      );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AttendanceData.fromJson(data["data"]);
      }
      return AttendanceData();
    } catch (e) {
      print("Create attendance exception: $e");
      return AttendanceData();
    }
  }

  /// Update attendance record
  Future<bool> updateAttendance(String id, AttendanceData attendance) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(attendance.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update attendance exception: $e");
      return false;
    }
  }

  /// Delete attendance record
  Future<bool> deleteAttendance(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete attendance exception: $e");
      return false;
    }
  }
}
