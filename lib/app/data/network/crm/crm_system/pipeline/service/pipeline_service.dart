import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';

class PipelineService {
  final String url = UrlRes.pipelines;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> getPipelines() async {
    try {
      final response = await http.get(
        Uri.parse('$url?client_id=true'),
        headers: await headers(),
      );
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data["success"] == true) {
        // Check different response formats
        if (data["data"] != null) {
          // Direct data format
          return data["data"] ?? [];
        } else if (data["message"] != null) {
          // If message is a string and data is elsewhere
          if (data["message"] is String && data["data"] != null) {
            return data["data"] ?? [];
          }
          // If data is nested under message
          else if (data["message"] is Map && data["message"]["data"] != null) {
            return data["message"]["data"] ?? [];
          }
        }
        return [];
      } else {
        String errorMessage = "Failed to fetch pipelines";
        if (data["message"] is String) {
          errorMessage = data["message"];
        }
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: errorMessage,
          contentType: ContentType.failure,
        );
        return [];
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch pipelines: $e",
        contentType: ContentType.failure,
      );
      return [];
    }
  }
}
