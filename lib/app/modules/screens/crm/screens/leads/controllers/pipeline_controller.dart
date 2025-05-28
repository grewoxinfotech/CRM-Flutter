import 'dart:math';

import 'package:crm_flutter/app/data/network/all/crm/crm_system/pipeline/pipeline_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/crm_system/pipeline/pipline_service.dart';
import 'package:get/get.dart';

class PipelineController extends GetxController {
  final PipelineService pipelineService = PipelineService();
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxString selectedPipeline = "".obs;
  final Rxn<PipelineModel> selectedPipelineModel = Rxn<PipelineModel>();

  @override
  void onInit() {
    super.onInit();
    getPipelines();
  }

  String getPipelineById(String id) {
    try {
      final pipeline = pipelines.firstWhere((p) => p.id.toString() == id);
      selectedPipelineModel.value = pipeline;
      return pipeline.pipelineName.toString();
    } catch (e) {
      selectedPipelineModel.value = null;
      print('Pipeline not found: $e');
      return "";
    }
  }

  Future<void> getPipelines() async {
    final data = await pipelineService.getPipelines();
    pipelines.assignAll(data.map((e) => PipelineModel.fromJson(e)).toList());
  }
}
