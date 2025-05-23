import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendanceService extends GetConnect {
  final String url = UrlRes.attendance;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> getAllAttendances() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["data"] != null) {
      print("Attendance Service (data) : ${data['data']}");
      return data['data'] ?? [];
    } else {
      print("Attendance Service (error) : ${data['message']}");
      print("Attendance Service (status code) : ${response.statusCode}");
      return [];
    }
  }

  Future<bool> punchIn(String employeeId) async {
    final response = await post('$baseUrl/punch-in', {
      'employee': employeeId,
      'startTime': DateTime.now().toIso8601String(),
    });
    return response.statusCode == 200;
  }

  Future<bool> punchOut(String id) async {
    final response = await post('$baseUrl/punch-out', {
      'id': id,
      'endTime': DateTime.now().toIso8601String(),
    });
    return response.statusCode == 200;
  }
}
