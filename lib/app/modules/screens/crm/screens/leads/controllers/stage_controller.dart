import 'package:crm_flutter/app/data/network/all/crm/crm_system/stage/stage_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/crm_system/stage/stage_service.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  final StageService stageService = StageService();
  final RxList<StageModel> stages = <StageModel>[].obs;
  final Rxn<StageModel> selectedStageModel = Rxn<StageModel>();

  @override
  void onInit() {
    super.onInit();
    getStages();
  }

  String getStageById(String id) {
    try {
      final stage = stages.firstWhere((p) => p.id.toString() == id);
      selectedStageModel.value = stage;
      return stage.stageName.toString();
    } catch (e) {
      selectedStageModel.value = null;
      print('Stage not found: $e');
      return "Stage";
    }
  }

  Future<void> getStages() async {
    final data = await stageService.getStages();
    stages.assignAll(data.map((e) => StageModel.fromJson(e)).toList());
  }
}
