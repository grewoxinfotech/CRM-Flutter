import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

class PipelineService {
  final String url = UrlRes.pipelines;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> getPipelines() async {
    final response = await http.get(
      Uri.parse('$url?client_id=true'),
      headers: await headers(),
    );
    final data = jsonDecode(response.body);
    return response.statusCode == 200 ? data["data"] ?? [] : [];
  }
}
