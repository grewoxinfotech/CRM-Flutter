import 'dart:convert';
import 'package:http/http.dart' as http;
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
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/crm/activity/controller/activity_controller.dart';

/// Controller for managing leads in the CRM system
class LeadController extends GetxController {
  RxBool isLoading = false.obs;

  // all service
  final LeadService leadService = LeadService();
  final StageService stageService = StageService();
  final PipelineService pipelineService = PipelineService();
  final LabelService labelService = LabelService();
  final NoteService noteService = NoteService();

  // Controllers
  late final StageController stageController;
  late final PipelineController pipelineController;
  late final ActivityController activityController;

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

  // Dropdown Options - Show names in UI
  List<String> get sourceOptions => labelService.getSources(labels).map((e) => e.id ?? '').toList();
  List<String> get categoryOptions => labelService.getCategories(labels).map((e) => e.id ?? '').toList();
  List<String> get statusOptions => labelService.getStatuses(labels).map((e) => e.id ?? '').toList();

  final List<String> interestLevelOptions = ['high', 'medium', 'low'];

  String getLabelId(String idOrName, String type) {
    final labelList = type == 'source' 
            ? labelService.getSources(labels)
            : type == 'category'
            ? labelService.getCategories(labels)
            : labelService.getStatuses(labels);

    final labelById = labelList.firstWhereOrNull((e) => e.id == idOrName);
    if (labelById != null) return labelById.id ?? '';
    
    final labelByName = labelList.firstWhereOrNull((e) => e.name == idOrName);
    return labelByName?.id ?? '';
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
    // Initialize controllers
    stageController = Get.put(StageController());
    pipelineController = Get.put(PipelineController());
    activityController = Get.put(ActivityController());
    // Load labels first
   
    refreshData();
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await getLabels();
    await Future.wait([
      getLeads(),
      getPipelines(),
      getStages(),
      getRoles(),
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
        pipelines.assignAll(data.map((e) => PipelineModel.fromJson(e)).toList());
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
      final response = await stageService.getStages(stageType: 'lead');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          stages.assignAll((data['data'] as List)
              .map((stage) => StageModel.fromJson(stage))
              .toList());
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
        message: 'Failed to fetch labels: ${e.toString()}',
        contentType: ContentType.failure,
      );
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

  // Update pipeline selection
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

    final defaultStage = pipelineStages.firstWhereOrNull((stage) => stage.isDefault) ?? pipelineStages.first;
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

  Future<List> getLeads() async {
    try {
      final data = await leadService.getLeads();
      if (data != null && data.isNotEmpty) {
        leads.assignAll(data.map((e) => LeadModel.fromJson(e)).toList());
        return data;
      }
      leads.clear();
      return [];
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
        'source': selectedSource.value,
        'category': selectedCategory.value,
        'status': selectedStatus.value,
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
      isLoading.value = true;
      await Future.wait([getPipelines(), getLabels(), getStages()]);
      
      final leadData = await leadService.getLeadById(leadId);
      if (leadData != null) {
        _clearFormValues();
        _setFormValues(leadData);
        update();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load lead details: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _setFormValues(Map<String, dynamic> leadData) {
    leadTitleController.text = leadData['leadTitle'] ?? '';
    leadValueController.text = leadData['leadValue']?.toString() ?? '';
    firstNameController.text = leadData['firstName'] ?? '';
    lastNameController.text = leadData['lastName'] ?? '';
    emailController.text = leadData['email'] ?? '';
    phoneController.text = leadData['phone'] ?? '';
    companyController.text = leadData['company'] ?? '';
    addressController.text = leadData['address'] ?? '';
    
    final pipelineId = leadData['pipeline'] ?? '';
    final pipeline = pipelines.firstWhereOrNull((p) => p.id == pipelineId);
    if (pipeline != null) {
      selectedPipeline.value = pipeline.pipelineName ?? '';
      selectedPipelineId.value = pipeline.id ?? '';
    }
    
    if (sourceOptions.contains(leadData['source'])) {
      selectedSource.value = leadData['source'] ?? '';
    }
    
    if (categoryOptions.contains(leadData['category'])) {
      selectedCategory.value = leadData['category'] ?? '';
    }
    
    if (statusOptions.contains(leadData['status'])) {
      selectedStatus.value = leadData['status'] ?? '';
    }
    
    final interestLevel = leadData['interest_level'] ?? '';
    selectedInterestLevel.value = interestLevelOptions.contains(interestLevel) 
        ? interestLevel 
        : 'medium';
    
    final stageId = leadData['leadStage'] ?? '';
    if (stages.isNotEmpty) {
      final stage = stages.firstWhereOrNull((s) => s.id == stageId);
      if (stage != null) {
        selectedStage.value = stage.stageName ?? '';
        selectedStageId.value = stage.id ?? '';
      }
    }
  }

  void _clearFormValues() {
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

  String getSourceName(String id) {
    if (id.isEmpty) return 'Unknown Source';
    return labelService.getSources(labels)
        .firstWhereOrNull((e) => e.id == id)
        ?.name ?? 'Unknown Source';
  }

  String getCategoryName(String id) {
    if (id.isEmpty) return 'Unknown Category';
    return labelService.getCategories(labels)
        .firstWhereOrNull((e) => e.id == id)
        ?.name ?? 'Unknown Category';
  }

  String getStatusName(String id) {
    if (id.isEmpty) return 'Unknown Status';
    return labelService.getStatuses(labels)
        .firstWhereOrNull((e) => e.id == id)
        ?.name ?? 'Unknown Status';
  }

  List<User> getLeadMembers(List<String> memberIds) {
    return users.where((user) => memberIds.contains(user.id)).toList();
  }

  String getStageName(String stageIdOrName) {
    return stageController.getStageName(stageIdOrName);
  }

  String getPipelineName(String pipelineIdOrName) {
    return pipelineController.getPipelineName(pipelineIdOrName);
  }

  Future<void> updateLead(String leadId) async {
    try {
      isLoading.value = true;

      if (!_validateLeadData()) return;

      final Map<String, dynamic> leadData = _getLeadData();
      final response = await leadService.updateLead(leadId, leadData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _handleSuccessfulUpdate(leadId);
      } else {
        _handleUpdateError(response);
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update lead: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateLeadData() {
    if (leadTitleController.text.trim().isEmpty) {
      _showValidationError('Lead title is required');
      return false;
    }

    if (leadValueController.text.trim().isEmpty) {
      _showValidationError('Lead value is required');
      return false;
    }

    if (selectedSource.value.isEmpty) {
      _showValidationError('Source is required');
      return false;
    }

    return true;
  }

  void _showValidationError(String message) {
    CrmSnackBar.showAwesomeSnackbar(
      title: 'Validation Error',
      message: message,
      contentType: ContentType.warning,
    );
  }

  Map<String, dynamic> _getLeadData() {
    return {
      'leadTitle': leadTitleController.text.trim(),
      'leadStage': selectedStageId.value,
      'pipeline': selectedPipelineId.value,
      'currency': 'USD',
      'leadValue': int.tryParse(leadValueController.text.trim()) ?? 0,
      'source': selectedSource.value,
      'category': selectedCategory.value,
      'status': selectedStatus.value,
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
  }

  Future<void> _handleSuccessfulUpdate(String leadId) async {
    final updatedLeadData = await leadService.getLeadById(leadId);
    if (updatedLeadData != null) {
      final index = leads.indexWhere((lead) => lead.id == leadId);
      if (index != -1) {
        leads[index] = LeadModel.fromJson(updatedLeadData);
        leads.refresh();
        update();
      }
    }
    
    _clearFormValues();
    
    CrmSnackBar.showAwesomeSnackbar(
      title: 'Success',
      message: 'Lead updated successfully',
      contentType: ContentType.success,
    );

    Get.back();
    refreshData();
  }

  void _handleUpdateError(http.Response response) {
    String errorMessage = 'Failed to update lead';
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

  Future<void> getLeadById(String leadId) async {
    try {
      final leadData = await leadService.getLeadById(leadId);
      if (leadData != null) {
        final index = leads.indexWhere((lead) => lead.id == leadId);
        if (index != -1) {
          leads[index] = LeadModel.fromJson(leadData);
          leads.refresh();
          update();
        } else {
          await getLeads();
        }
      }
    } catch (e) {
      await getLeads();
    }
  }
}
