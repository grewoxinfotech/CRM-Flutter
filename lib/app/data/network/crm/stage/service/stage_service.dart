// import 'dart:convert';
//
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
// import 'package:crm_flutter/app/data/network/crm/crm_system/stage/stage_model.dart';
// import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
// import 'package:crm_flutter/app/care/constants/url_res.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
//
// class StageService extends GetxService {
//
//   final String url = UrlRes.stages;
//
//   Future<List<StageModel>> getStages({String? stageType, String? clientId}) async {
//     try {
//       // Get the auth token
//       final token = await SecureStorage.getToken();
//
//       final userdata = await SecureStorage.getUserData();
//
//       if (token == null) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Error',
//           message: 'Authentication token not found',
//           contentType: ContentType.failure,
//         );
//         return [];
//       }
//
//       final queryParams = <String, String>{};
//       if (stageType != null) queryParams['stageType'] = "lead";
//       if (clientId != null) queryParams['client_id'] = "${userdata?.id.toString()}";
//
//       final uri = Uri.parse(url).replace(queryParameters: queryParams);
//
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//           'Origin': 'https://crm.raiser.in',
//           'Referer': 'https://crm.raiser.in/',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true && data['data'] != null) {
//           final stagesList = (data['data'] as List)
//               .where((stage) => stage['stageType'] == stageType) // Filter by stage type
//               .map((stage) => StageModel.fromJson(stage))
//               .toList();
//
//           return stagesList;
//         } else {
//           CrmSnackBar.showAwesomeSnackbar(
//             title: 'Error',
//             message: data['message'] ?? 'Failed to fetch stages',
//             contentType: ContentType.failure,
//           );
//           return [];
//         }
//       } else if (response.statusCode == 401) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Authentication Error',
//           message: 'Please login again',
//           contentType: ContentType.failure,
//         );
//         return [];
//       } else {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: 'Error',
//           message: 'Failed to fetch stages: ${response.statusCode}',
//           contentType: ContentType.failure,
//         );
//         return [];
//       }
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: 'Error',
//         message: 'Failed to fetch stages: ${e.toString()}',
//         contentType: ContentType.failure,
//       );
//       return [];
//     }
//   }
//
//   Future<List<StageModel>> getStagesByPipeline(String pipelineId) async {
//     try {
//       print('Selected Pipeline ID: $pipelineId');
//       final stages = await getStages(stageType: 'lead');
//       final filteredStages = stages.where((stage) => stage.pipeline == pipelineId).toList();
//
//       // Print only the stages for selected pipeline
//       for (var stage in filteredStages) {
//         print('Stage: ${stage.stageName} (${stage.isDefault ? 'Default' : 'Not Default'})');
//       }
//
//       return filteredStages;
//     } catch (e) {
//       print('Error getting stages by pipeline: $e');
//       return [];
//     }
//   }
//
//   Future<StageModel?> getDefaultStageForPipeline(String pipelineId) async {
//     try {
//       final stages = await getStagesByPipeline(pipelineId);
//       final defaultStage = stages.firstWhereOrNull((stage) => stage.isDefault);
//
//       if (defaultStage != null) {
//         print('Default Stage: ${defaultStage.stageName}');
//       }
//
//       return defaultStage;
//     } catch (e) {
//       print('Error getting default stage: $e');
//       return null;
//     }
//   }
// }