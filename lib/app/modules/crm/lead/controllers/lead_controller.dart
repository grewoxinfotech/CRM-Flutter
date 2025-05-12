import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/model/stage_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/model/pipeline_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/service/pipeline_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/crm/lead/service/lead_service.dart';
import 'package:crm_flutter/app/data/network/role/service/roles_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/service/stage_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing leads in the CRM system
class LeadController extends GetxController {
  RxBool isLoading = false.obs;

  // all service
  final LeadService leadService = LeadService();
  final StageService stageService = StageService();
  final PipelineService pipelineService = PipelineService();
  final LabelService labelService = LabelService();
  final NoteService noteService = NoteService();

  //Temporary service to fetch all users
  final AllUsersService allUsersService = AllUsersService();
  final RolesService rolesService = RolesService();

  // State Variables
  final RxList<LeadModel> leads = <LeadModel>[].obs;
  final RxList<StageModel> stages = <StageModel>[].obs;
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxList<LabelModel> labels = <LabelModel>[].obs;
  final RxList<User> users = <User>[].obs;
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  // final RxList<AllUserModel> allUsers = <AllUserModel>[].obs;
  // final RxList<RolesModel> roless = <RolesModel>[].obs;

  // Form Controllers
  final leadTitleController = TextEditingController();
  final leadValueController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();

  // Dropdown Selections
  final selectedPipeline = ''.obs;
  final selectedPipelineId = ''.obs;
  final selectedSource = ''.obs;
  final selectedCategory = ''.obs;
  final selectedInterestLevel = ''.obs;
  final selectedStage = ''.obs;
  final selectedStageId = ''.obs;
  final selectedStatus = ''.obs;

  // Note type selection
  final selectedNoteType = ''.obs;
  final List<String> noteTypeOptions = ['important', 'normal', 'urgent'];

  // Dropdown Options - Show names in UI
  List<String> get sourceOptions =>
      labelService.getSources(labels).map((e) => e.name).toList();

  List<String> get categoryOptions =>
      labelService.getCategories(labels).map((e) => e.name).toList();

  List<String> get statusOptions =>
      labelService.getStatuses(labels).map((e) => e.name).toList();

  final List<String> interestLevelOptions = ['high', 'medium', 'low'];

  String getLabelId(String name, String type) {
    final labelList =
        type == 'source'
            ? labelService.getSources(labels)
            : type == 'category'
            ? labelService.getCategories(labels)
            : labelService.getStatuses(labels);

    return labelList
        .firstWhere(
          (e) => e.name == name,
          orElse:
              () => LabelModel(
                id: '',
                relatedId: '',
                labelType: type,
                name: '',
                color: '',
                clientId: '',
                createdBy: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
        )
        .id;
  }

  @override
  void onClose() {
    leadTitleController.dispose();
    leadValueController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    addressController.dispose();
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    await Future.wait([
      getLeads(),
      getPipelines(),
      getStages(),
      getLabels(),
      getRoles(),
      //Temporary function to fetch all users
      getAllUsers(),
    ]);
  }

  Future<void> getPipelines() async {
    try {
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
        message: 'Failed to fetch pipelines',
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> getStages() async {
    try {
      final stagesList = await stageService.getStages(stageType: 'lead');
      if (stagesList.isNotEmpty) {
        stages.assignAll(stagesList);
      } else {
        stages.clear();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch stages',
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> getRoles() async {
    try {
      await rolesService.getRoles();
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch roles',
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> getLabels() async {
    try {
      final labelsList = await labelService.getLabels();
      labels.assignAll(labelsList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch labels',
        contentType: ContentType.failure,
      );
    }
  }

  // Get stages for a specific pipeline
  List<StageModel> getStagesForPipeline(String pipelineId) {
    if (pipelineId.isEmpty) return [];
    return stages.where((stage) => stage.pipeline == pipelineId).toList();
  }

  // Get default stage for a pipeline
  StageModel? getDefaultStageForPipeline(String pipelineId) {
    if (pipelineId.isEmpty) return null;
    return stages.firstWhereOrNull(
      (stage) => stage.pipeline == pipelineId && stage.isDefault,
    );
  }

  // Update pipeline selection
  void updatePipeline(String? pipelineName, String? pipelineId) {
    if (pipelineName == null || pipelineId == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Validation Error',
        message: 'Please select a valid pipeline',
        contentType: ContentType.warning,
      );
      selectedPipeline.value = '';
      selectedPipelineId.value = '';
      selectedStage.value = '';
      selectedStageId.value = '';
      return;
    }

    final pipelineExists = pipelines.any((p) => p.id == pipelineId);
    if (!pipelineExists) {
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

    final defaultStage = pipelineStages.firstWhereOrNull((stage) => stage.isDefault);
    if (defaultStage != null) {
      selectedStage.value = defaultStage.stageName;
      selectedStageId.value = defaultStage.id;
    } else {
      final firstStage = pipelineStages.first;
      selectedStage.value = firstStage.stageName;
      selectedStageId.value = firstStage.id;
    }

    update();
  }

  Future<List> getLeads() async {
    try {
      final data = await leadService.getLeads();
      if (data != null && data.isNotEmpty) {
        final leadsList = data.map((e) => LeadModel.fromJson(e)).toList();
        leads.assignAll(leadsList);
        return data;
      } else {
        leads.clear();
        return [];
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch leads: ${e.toString()}',
        contentType: ContentType.failure,
      );
      leads.clear();
      return [];
    }
  }

  Future<void> addLead() async {
    try {
      isLoading.value = true;
     
      if (selectedPipelineId.value.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Please select a pipeline',
          contentType: ContentType.warning,
        );
        return;
      }

      if (selectedStageId.value.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Please select a stage',
          contentType: ContentType.warning,
        );
        return;
      }

      if (leadTitleController.text.trim().isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Lead title is required',
          contentType: ContentType.warning,
        );
        return;
      }

      if (leadValueController.text.trim().isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Lead value is required',
          contentType: ContentType.warning,
        );
        return;
      }

      if (selectedSource.value.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Source is required',
          contentType: ContentType.warning,
        );
        return;
      }

      final Map<String, dynamic> leadData = {
        'leadTitle': leadTitleController.text.trim(),
        'leadStage': selectedStageId.value,
        'pipeline': selectedPipelineId.value,
        'currency': 'USD',
        'leadValue': int.tryParse(leadValueController.text.trim()) ?? 0,
        'source': getLabelId(selectedSource.value, 'source'),
        'category': getLabelId(selectedCategory.value, 'category'),
        'status': getLabelId(selectedStatus.value, 'status'),
        'interest_level': selectedInterestLevel.value.isEmpty ? 'medium' : selectedInterestLevel.value,
        'client_id': 'default',
        'created_by': 'default',
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'company': companyController.text.trim(),
        'address': addressController.text.trim(),
      };

      final response = await leadService.createLead(leadData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        leadTitleController.clear();
        leadValueController.clear();
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        phoneController.clear();
        companyController.clear();
        addressController.clear();
        selectedPipeline.value = '';
        selectedPipelineId.value = '';
        selectedSource.value = '';
        selectedCategory.value = '';
        selectedInterestLevel.value = '';
        selectedStage.value = '';
        selectedStageId.value = '';
        selectedStatus.value = '';

        await refreshData();
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Lead created successfully',
          contentType: ContentType.success,
        );
      } else {
        String errorMessage = 'Failed to create lead';
        try {
          final responseData = jsonDecode(response.body);
          if (responseData is Map) {
            errorMessage = responseData['message'] ?? responseData['error'] ?? errorMessage;
          }
        } catch (e) {}

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: errorMessage,
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create lead: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editLead(String leadId) async {
    try {
      final leadData = await leadService.getLeadById(leadId);
      if (leadData != null) {
        leadTitleController.text = leadData['title'] ?? '';
        selectedPipeline.value = leadData['pipeline'] ?? '';
        selectedPipelineId.value = leadData['pipeline'] ?? '';
        leadValueController.text = leadData['value'] ?? '';
        selectedSource.value = leadData['source'] ?? '';
        selectedCategory.value = leadData['category'] ?? '';
        selectedInterestLevel.value = leadData['interestLevel'] ?? '';
        selectedStage.value = leadData['stage'] ?? '';
        selectedStageId.value = leadData['stage'] ?? '';
        selectedStatus.value = leadData['status'] ?? '';
        firstNameController.text = leadData['firstName'] ?? '';
        lastNameController.text = leadData['lastName'] ?? '';
        emailController.text = leadData['email'] ?? '';
        phoneController.text = leadData['phone'] ?? '';
        companyController.text = leadData['company'] ?? '';
        addressController.text = leadData['address'] ?? '';
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch lead details',
        contentType: ContentType.failure,
      );
    }
  }

  Future<bool> deleteLead(String id) async {
    try {
      final isDeleted = await leadService.deleteLead(id);
      if (isDeleted) {
        await getLeads();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Lead deleted successfully',
          contentType: ContentType.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete lead',
        contentType: ContentType.failure,
      );
      return false;
    }
  }

//Temporary function to fetch all users
  Future<void> getAllUsers() async {
    try {
      final usersList = await allUsersService.getUsers();
      users.assignAll(usersList);
      print('Successfully fetched ${users.length} users');
    } catch (e) {
      print('Error fetching users: $e');
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch users: ${e.toString()}',
        contentType: ContentType.failure,
      );
    }
  }

  // get label names for display
  String getSourceName(String id) {
    return labelService
        .getSources(labels)
        .firstWhere(
          (e) => e.id == id,
          orElse:
              () => LabelModel(
                id: '',
                relatedId: '',
                labelType: 'source',
                name: '',
                color: '',
                clientId: '',
                createdBy: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
        )
        .name;
  }

  String getCategoryName(String id) {
    return labelService
        .getCategories(labels)
        .firstWhere(
          (e) => e.id == id,
          orElse:
              () => LabelModel(
                id: '',
                relatedId: '',
                labelType: 'category',
                name: '',
                color: '',
                clientId: '',
                createdBy: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
        )
        .name;
  }

  String getStatusName(String id) {
    return labelService
        .getStatuses(labels)
        .firstWhere(
          (e) => e.id == id,
          orElse:
              () => LabelModel(
                id: '',
                relatedId: '',
                labelType: 'status',
                name: '',
                color: '',
                clientId: '',
                createdBy: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
        )
        .name;
  }

  // Add this method to get filtered users by member IDs
  List<User> getLeadMembers(List<String> memberIds) {
    return users.where((user) => memberIds.contains(user.id)).toList();
  }
}
