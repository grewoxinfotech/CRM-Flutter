import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/service/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskService extends GetConnect {
  final String url = UrlRes.task;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> getTasks(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    final data = jsonDecode(response.body);
    return (response.statusCode == 200) ? data['data'] ?? [] : [];
  }

  Future<bool> deleteTask(String id) async {
    try {
      String? token = await SecureStorage.getToken();
      if (token == null)
        throw Exception("No token found. Please log in again.");

      final response = await delete(
        "$url/$id",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        return response.body["success"] == true;
      } else {
        print("Delete failed: ${response.statusText}");
        CrmSnackBar.showAwesomeSnackbar(
          title: "Delete Failed",
          message: "${response.body["message"]}",
          contentType: ContentType.warning,
          color: ColorRes.error,
        );
        return false;
      }
    } catch (e) {
      print("Error deleting task: $e");
      return false;
    }
  }
}
