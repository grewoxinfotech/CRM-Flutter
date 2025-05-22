import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/data/network/crm/deal/service/deal_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/service/pipeline_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/model/pipeline_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/service/stage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/model/stage_model.dart';
import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/crm/activity/controller/activity_controller.dart';

class DealController extends GetxController {
  final RxBool isLoading = false.obs;

  // Services
  final DealService dealService = DealService();
  final StageService stageService = StageService();
  final PipelineService pipelineService = PipelineService();
  final LabelService labelService = LabelService();
  final AllUsersService allUsersService = AllUsersService();
  final NoteService noteService = NoteService();

  // Controllers
  late final ActivityController activityController;

  // State Variables
  final RxList<DealModel> deal = <DealModel>[].obs;
  final RxList<StageModel> stages = <StageModel>[].obs;
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxList<LabelModel> labels = <LabelModel>[].obs;
  final RxList<User> users = <User>[].obs;
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  // Form Controllers
  final dealTitle = TextEditingController();
  final dealValue = TextEditingController();
  final pipeline = TextEditingController();
  final stage = TextEditingController();
  final closeDate = TextEditingController();
  final source = TextEditingController();
  final status = TextEditingController();
  final products = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final companyName = TextEditingController();
  final address = TextEditingController();
  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();

  // Dropdown Selections
  final selectedPipeline = ''.obs;
  final selectedPipelineId = ''.obs;
  final selectedSource = ''.obs;
  final selectedStage = ''.obs;
  final selectedStageId = ''.obs;
  final selectedStatus = ''.obs;

  // Dropdown Options - Show names in UI
  List<String> get sourceOptions =>
      labelService.getSources(labels).map((e) => e.id ?? '').toList();
  List<String> get statusOptions =>
      labelService.getStatuses(labels).map((e) => e.id ?? '').toList();

  @override
  void onInit() {
    super.onInit();
    activityController = Get.put(ActivityController());
    refreshData();
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await getLabels();
      await Future.wait([
        getDeals(),
        getPipelines(),
        getStages(),
        getAllUsers(),
      ]);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to refresh data: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPipelines() async {
    try {
      final data = await pipelineService.getPipelines();
      if (data != null && data.isNotEmpty) {
        pipelines.assignAll(
          data.map((e) => PipelineModel.fromJson(e)).toList(),
        );
      } else {
        pipelines.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch pipelines',
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> getStages() async {
    try {
      final response = await stageService.getStages(stageType: 'deal');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final dealStages =
              (data['data'] as List)
                  .where((stage) => stage['stageType'] == 'deal')
                  .map((stage) => StageModel.fromJson(stage))
                  .toList();
          stages.assignAll(dealStages);
        } else {
          stages.clear();
        }
      } else {
        stages.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch stages',
        contentType: ContentType.failure,
      );
      stages.clear();
    }
  }

  Future<void> getLabels() async {
    try {
      final labelsList = await labelService.getLabels();
      labels.assignAll(labelsList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch labels: ${e.toString()}',
        contentType: ContentType.failure,
      );
    }
  }

  Future<List> getDeals() async {
    try {
      final data = await dealService.getDeals();
      deal.assignAll(data.map((e) => DealModel.fromJson(e)).toList());
      return data;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch deals: ${e.toString()}',
        contentType: ContentType.failure,
      );
      deal.clear();
      return [];
    }
  }

  // Get stage name by ID or name
  String getStageName(String stageIdOrName) {
    try {
      if (stageIdOrName.isEmpty) return 'Unknown Stage';

      // First try to find by ID
      final stageById = stages.firstWhereOrNull((s) => s.id == stageIdOrName);
      if (stageById != null) {
        return stageById.stageName ?? 'Unknown Stage';
    }

      // If not found by ID, try to find by name
      final stageByName = stages.firstWhereOrNull(
        (s) => s.stageName == stageIdOrName,
      );
      return stageByName?.stageName ?? 'Unknown Stage';
    } catch (e) {
      print('Error getting stage name: $e');
      return 'Unknown Stage';
    }
  }

  // Get pipeline name by ID or name
  String getPipelineName(String pipelineIdOrName) {
    try {
      if (pipelineIdOrName.isEmpty) return 'Unknown Pipeline';

      // First try to find by ID
      final pipelineById = pipelines.firstWhereOrNull(
        (p) => p.id == pipelineIdOrName,
      );
      if (pipelineById != null) {
        return pipelineById.pipelineName ?? 'Unknown Pipeline';
      }

      // If not found by ID, try to find by name
      final pipelineByName = pipelines.firstWhereOrNull(
        (p) => p.pipelineName == pipelineIdOrName,
      );
      return pipelineByName?.pipelineName ?? 'Unknown Pipeline';
    } catch (e) {
      print('Error getting pipeline name: $e');
      return 'Unknown Pipeline';
    }
  }

  String getSourceName(String id) {
    try {
      if (id.isEmpty) return 'Unknown Source';
      final sources = labelService.getSources(labels);
      final source = sources.firstWhereOrNull((e) => e.id == id);
      return source?.name ?? 'Unknown Source';
    } catch (e) {
      print('Error getting source name: $e');
      return 'Unknown Source';
    }
  }

  String getStatusName(String id) {
    try {
      if (id.isEmpty) return 'Unknown Status';
      final statuses = labelService.getStatuses(labels);
      final status = statuses.firstWhereOrNull((e) => e.id == id);
      return status?.name ?? 'Unknown Status';
    } catch (e) {
      print('Error getting status name: $e');
      return 'Unknown Status';
    }
  }

  List<StageModel> getStagesForPipeline(String pipelineId) {
    if (pipelineId.isEmpty) return [];
    return stages.where((stage) => stage.pipeline == pipelineId).toList();
  }

  StageModel? getDefaultStageForPipeline(String pipelineId) {
    if (pipelineId.isEmpty) return null;
    return stages.firstWhereOrNull(
      (stage) => stage.pipeline == pipelineId && stage.isDefault,
    );
  }

  void updatePipeline(String? pipelineName, String? pipelineId) {
    if (pipelineName == null || pipelineId == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Validation Error',
        message: 'Please select a valid pipeline',
        contentType: ContentType.warning,
      );
      _clearPipelineValues();
      return;
    }

    if (!pipelines.any((p) => p.id == pipelineId)) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Selected pipeline not found',
        contentType: ContentType.failure,
      );
      return;
    }

    selectedPipeline.value = pipelineName;
    selectedPipelineId.value = pipelineId;

    final pipelineStages = getStagesForPipeline(pipelineId);
    if (pipelineStages.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Warning',
        message: 'No stages found for selected pipeline',
        contentType: ContentType.warning,
      );
      selectedStage.value = '';
      selectedStageId.value = '';
      return;
    }

    final defaultStage =
        pipelineStages.firstWhereOrNull((stage) => stage.isDefault) ??
        pipelineStages.first;
    selectedStage.value = defaultStage.stageName;
    selectedStageId.value = defaultStage.id;
    update();
  }

  void _clearPipelineValues() {
    selectedPipeline.value = '';
    selectedPipelineId.value = '';
    selectedStage.value = '';
    selectedStageId.value = '';
  }

  String getLabelId(String idOrName, String type) {
    final labelList =
        type == 'source'
            ? labelService.getSources(labels)
            : labelService.getStatuses(labels);

    final labelById = labelList.firstWhereOrNull((e) => e.id == idOrName);
    if (labelById != null) return labelById.id ?? '';

    final labelByName = labelList.firstWhereOrNull((e) => e.name == idOrName);
    return labelByName?.id ?? '';
  }

  List<User> getDealMembers(List<String> memberIds) {
    try {
      if (memberIds.isEmpty) return [];
      return users.where((user) => memberIds.contains(user.id)).toList();
    } catch (e) {
      print('Error getting deal members: $e');
      return [];
    }
  }

  Future<void> getAllUsers() async {
    try {
      final usersList = await allUsersService.getUsers();
      users.assignAll(usersList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch users: ${e.toString()}',
        contentType: ContentType.failure,
      );
    }
  }

  Future<bool> deleteDeal(String id) async {
    try {
      final isDeleted = await dealService.deleteDeal(id);
      if (isDeleted) {
        await getDeals();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Deal deleted successfully',
          contentType: ContentType.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete deal',
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  Future<void> getDealById(String dealId) async {
    try {
      final dealData = await dealService.getDealById(dealId);
      if (dealData != null) {
        final index = deal.indexWhere((d) => d.id == dealId);
        if (index != -1) {
          deal[index] = DealModel.fromJson(dealData);
          deal.refresh();
          update();
        } else {
          await getDeals();
        }
      }
    } catch (e) {
      await getDeals();
    }
  }

  Future<void> editDeal(String dealId) async {
    try {
      final dealData = await dealService.getDealById(dealId);
      if (dealData != null) {
        final dealModel = DealModel.fromJson(dealData);
        dealTitle.text = dealModel.dealTitle ?? '';
        dealValue.text = dealModel.value?.toString() ?? '';
        pipeline.text = dealModel.pipeline ?? '';
        stage.text = dealModel.stage ?? '';
        closeDate.text = dealModel.closedDate?.toString() ?? '';
        source.text = dealModel.source ?? '';
        status.text = dealModel.status ?? '';
        products.text = dealModel.products?.toString() ?? '';
        firstName.text = dealModel.firstName ?? '';
        lastName.text = dealModel.lastName ?? '';
        email.text = dealModel.email ?? '';
        phoneNumber.text = dealModel.phone ?? '';
        companyName.text = dealModel.companyName ?? '';
        address.text = dealModel.address ?? '';

        selectedPipeline.value = dealModel.pipeline ?? '';
        selectedSource.value = dealModel.source ?? '';
        selectedStage.value = dealModel.stage ?? '';
        selectedStatus.value = dealModel.status ?? '';
      }
    } catch (e) {
      print('Error editing deal: $e');
    }
  }

  Future<void> updateDeal(String dealId) async {
    try {
      isLoading.value = true;

      final data = {
        'dealTitle': dealTitle.text,
        'value': int.tryParse(dealValue.text) ?? 0,
        'pipeline': selectedPipeline.value,
        'stage': selectedStage.value,
        'closedDate': closeDate.text,
        'source': selectedSource.value,
        'status': selectedStatus.value,
        'products': products.text,
        'firstName': firstName.text,
        'lastName': lastName.text,
        'email': email.text,
        'phone': phoneNumber.text,
        'companyName': companyName.text,
        'address': address.text,
      };

      final response = await dealService.updateDeal(dealId, data);
      if (response != null) {
        await refreshData();
        Get.back();
        Get.snackbar('Success', 'Deal updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update deal: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    dealTitle.dispose();
    dealValue.dispose();
    pipeline.dispose();
    stage.dispose();
    closeDate.dispose();
    source.dispose();
    status.dispose();
    products.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    companyName.dispose();
    address.dispose();
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    super.onClose();
  }
}
