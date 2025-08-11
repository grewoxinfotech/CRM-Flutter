import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/model/pipeline_model.dart'; 
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/service/pipeline_service.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class PipelineController extends GetxController {
  final PipelineService pipelineService = PipelineService();
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPipelines();
  }

  Future<void> getPipelines() async {
    try {
      isLoading.value = true;
      final data = await pipelineService.getPipelines();
      if (data != null && data.isNotEmpty) {
        final pipelinesList = data.map((e) => PipelineModel.fromJson(e)).toList();
        pipelines.assignAll(pipelinesList);
      } else {
        pipelines.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch pipelines: ${e.toString()}',
        contentType: ContentType.failure,
      );
      pipelines.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Get pipeline name by ID or name
  String getPipelineName(String pipelineIdOrName) {
    try {
      // First try to find by ID
      final pipelineById = pipelines.firstWhereOrNull((pipeline) => pipeline.id == pipelineIdOrName);
      if (pipelineById != null) {
        return pipelineById.pipelineName ?? 'Unknown Pipeline';
      }
      
      // If not found by ID, try to find by name
      final pipelineByName = pipelines.firstWhereOrNull((pipeline) => pipeline.pipelineName == pipelineIdOrName);
      if (pipelineByName != null) {
        return pipelineByName.pipelineName ?? 'Unknown Pipeline';
      }
      
      return 'Unknown Pipeline';
    } catch (e) {
      return 'Unknown Pipeline';
    }
  }
}
