import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/models/crm/pipeline/pipeline_model.dart';

class PipelineService {
  final String url = UrlRes.pipelines;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List<PipelineModel>> getPipelines() async {
    try {
      final response = await http.get(
        Uri.parse('$url?client_id=true'),
        headers: await headers(),
      );

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200 && responseData['success'] == true) {
        final List<dynamic> data = responseData['data'];
        //print("Pipeline data: $data");
        return data.map((json) => PipelineModel.fromJson(json)).toList();
      } else {
        throw Exception(responseData['message'] ?? 'Failed to fetch pipelines');
      }
    } catch (e) {
      throw Exception('Failed to fetch pipelines: $e');
    }
  }
} 