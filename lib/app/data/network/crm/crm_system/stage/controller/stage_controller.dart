import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/model/stage_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/service/stage_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  final StageService stageService = StageService();
  final RxList<StageModel> stages = <StageModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStages();
  }

  /// Get all stages
  Future<void> getStages({String? stageType, String? clientId}) async {
    try {
      isLoading.value = true;
      final response = await stageService.getStages(stageType: stageType, clientId: clientId);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final stagesList = (data['data'] as List)
              .map((stage) => StageModel.fromJson(stage))
              .toList();
          stages.assignAll(stagesList);
        } else {
          CrmSnackBar.showAwesomeSnackbar(
            title: 'Error',
            message: data['message'] ?? 'Failed to fetch stages',
            contentType: ContentType.failure,
          );
        }
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to fetch stages: ${response.statusCode}',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch stages: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get stages by pipeline
  Future<List<StageModel>> getStagesByPipeline(String pipelineId) async {
    try {
      final response = await stageService.getStagesByPipeline(pipelineId);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data'] as List)
              .map((stage) => StageModel.fromJson(stage))
              .toList();
        }
      }
      return [];
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch stages by pipeline: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return [];
    }
  }

  /// Get default stage for pipeline
  Future<StageModel?> getDefaultStageForPipeline(String pipelineId) async {
    try {
      final response = await stageService.getDefaultStageForPipeline(pipelineId);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return StageModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch default stage: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return null;
    }
  }

  /// Get stage by ID
  StageModel? getStageById(String stageId) {
    try {
      return stages.firstWhere((stage) => stage.id == stageId);
    } catch (e) {
      print('Error finding stage by ID: $e');
      return null;
    }
  }

  /// Get stage name by ID or name
  String getStageName(String stageIdOrName) {
    try {
      print('Looking for stage: $stageIdOrName');
      print('Available stages: ${stages.map((s) => '${s.id}: ${s.stageName}').join(', ')}');
      
      // First try to find by ID
      final stageById = stages.firstWhereOrNull((stage) => stage.id == stageIdOrName);
      if (stageById != null) {
        return stageById.stageName;
      }
      
      // If not found by ID, try to find by name
      final stageByName = stages.firstWhereOrNull((stage) => stage.stageName == stageIdOrName);
      if (stageByName != null) {
        return stageByName.stageName;
      }
      
      return 'Unknown Stage';
    } catch (e) {
      print('Stage not found error: $e');
      return 'Unknown Stage';
    }
  }

  /// Get stages by type
  List<StageModel> getStagesByType(String stageType) {
    return stages.where((stage) => stage.stageType == stageType).toList();
  }

  /// Create new stage
  Future<bool> createStage(Map<String, dynamic> data) async {
    try {
      final response = await stageService.createStage(data);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          await getStages(); // Refresh the stages list
          return true;
        }
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create stage: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Update stage
  Future<bool> updateStage(String stageId, Map<String, dynamic> data) async {
    try {
      final response = await stageService.updateStage(stageId, data);
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          await getStages(); // Refresh the stages list
          return true;
        }
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update stage: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete stage
  Future<bool> deleteStage(String stageId) async {
    try {
      final response = await stageService.deleteStage(stageId);
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          await getStages(); // Refresh the stages list
          return true;
        }
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete stage: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return false;
    }
  }
} 