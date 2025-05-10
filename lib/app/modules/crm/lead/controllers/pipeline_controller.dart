import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/model/pipeline_model.dart'; 
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/service/pipeline_service.dart';
import 'package:get/get.dart';

class PipelineController extends GetxController {
  final PipelineService pipelineService = PipelineService();
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPipelines();
  }

  Future<void> getPipelines() async {
    final data = await pipelineService.getPipelines();
    pipelines.assignAll(data.map((e) => PipelineModel.fromJson(e)).toList());
  }
}
