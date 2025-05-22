import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/model/stage_model.dart'; 
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class StageService extends GetxService {

  final String url = UrlRes.stages;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Get all stages
  Future<http.Response> getStages({String? stageType, String? clientId}) async {
      final queryParams = <String, String>{};
    if (stageType != null) queryParams['stageType'] = stageType;
    if (clientId != null) queryParams['client_id'] = clientId;

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

    return await http.get(
      uri,
      headers: await headers(),
    );
  }

  /// Get stages by pipeline ID
  Future<http.Response> getStagesByPipeline(String pipelineId) async {
    final uri = Uri.parse('$url/pipeline/$pipelineId');
    return await http.get(
      uri,
      headers: await headers(),
    );
  }

  /// Get default stage for pipeline
  Future<http.Response> getDefaultStageForPipeline(String pipelineId) async {
    final uri = Uri.parse('$url/pipeline/$pipelineId/default');
    return await http.get(
      uri,
      headers: await headers(),
    );
  }

  /// Create new stage
  Future<http.Response> createStage(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// Update stage
  Future<http.Response> updateStage(String stageId, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse('$url/$stageId'),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// Delete stage
  Future<http.Response> deleteStage(String stageId) async {
    return await http.delete(
      Uri.parse('$url/$stageId'),
      headers: await headers(),
    );
  }
}