import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeaveService extends GetConnect {
  static final String url = UrlRes.leaves;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  static Future<List<LeaveModel>> getLeaves() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Leave Service (data) : ${jsonData['data']}");
      return data.map((e) => LeaveModel.fromJson(e)).toList();
    } else {
      print("Leave Service (error) : ${jsonData['message']}");
      print("Leave Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load leave data: ${response.statusCode}');
    }
  }
}
