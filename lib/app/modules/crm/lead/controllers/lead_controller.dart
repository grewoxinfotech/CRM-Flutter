import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/data/service/lead_service.dart';
import 'package:crm_flutter/app/data/service/pipeline_service.dart';
import 'package:crm_flutter/app/data/service/stage_service.dart';
import 'package:crm_flutter/app/data/service/label_service.dart';
import 'package:crm_flutter/app/data/models/crm/lead/lead_model.dart';
import 'package:crm_flutter/app/data/models/crm/pipeline/pipeline_model.dart';
import 'package:crm_flutter/app/data/models/crm/stage/stage_model.dart';
import 'package:crm_flutter/app/data/models/crm/label/label_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Controller for managing leads in the CRM system
class LeadController extends GetxController {
  // Dependencies
  late final LeadService _leadService;
  late final PipelineService _pipelineService;
  late final StageService _stageService;
  late final LabelService _labelService;

  // State Variables
  final RxList<LeadModel> leads = <LeadModel>[].obs;
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxList<StageModel> stages = <StageModel>[].obs;
  final RxList<LabelModel> labels = <LabelModel>[].obs;
  final isLoading = false.obs;

  // Form Controllers
  final leadTitleController = TextEditingController();
  final leadValueController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();

  // Dropdown Selections
  final selectedPipeline = ''.obs;
  final selectedPipelineId = ''.obs;
  final selectedSource = ''.obs;
  final selectedCategory = ''.obs;
  final selectedInterestLevel = ''.obs;
  final selectedStage = ''.obs;
  final selectedStageId = ''.obs;
  final selectedStatus = ''.obs;

  // Dropdown Options - Show names in UI
  List<String> get sourceOptions => _labelService.getSources(labels).map((e) => e.name).toList();
  List<String> get categoryOptions => _labelService.getCategories(labels).map((e) => e.name).toList();
  List<String> get statusOptions => _labelService.getStatuses(labels).map((e) => e.name).toList();

  final List<String> interestLevelOptions = [
    'high',
    'medium',
    'low',
  ];

  // Helper method to get ID from name and type
  String getLabelId(String name, String type) {
    final labelList = type == 'source' ? _labelService.getSources(labels) :
                     type == 'category' ? _labelService.getCategories(labels) :
                     _labelService.getStatuses(labels);
    
    return labelList.firstWhere((e) => e.name == name, orElse: () => LabelModel(
      id: '',
      relatedId: '',
      labelType: type,
      name: '',
      color: '',
      clientId: '',
      createdBy: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )).id;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeServices();
    refreshData();
  }

  void _initializeServices() {
    try {
      _leadService = Get.find<LeadService>();
      _pipelineService = Get.find<PipelineService>();
      _stageService = Get.find<StageService>();
      _labelService = Get.find<LabelService>();
    } catch (e) {
      _leadService = Get.put(LeadService());
      _pipelineService = Get.put(PipelineService());
      _stageService = Get.put(StageService());
      _labelService = Get.put(LabelService());
    }
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
    super.onClose();
  }

  Future<void> refreshData() async {
    await Future.wait([
      getLeads(),
      getPipelines(),
      getStages(),
      getLabels(),
    ]);
  }

  Future<void> getLabels() async {
    try {
      isLoading.value = true;
      final labelsList = await _labelService.getLabels();
      labels.assignAll(labelsList);
    } catch (e) {
      print('Error in getLabels: $e');
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch labels',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStages() async {
    try {
      isLoading.value = true;
      final stagesList = await _stageService.getStages(stageType: 'lead');
      stages.assignAll(stagesList);
    } catch (e) {
      print('Error in getStages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get stages for a specific pipeline
  List<StageModel> getStagesForPipeline(String pipelineId) {
    if (pipelineId.isEmpty) return [];
    final pipelineStages = stages.where((stage) => stage.pipeline == pipelineId).toList();
    
    // Sort stages to put default stage first
    pipelineStages.sort((a, b) {
      if (a.isDefault) return -1;
      if (b.isDefault) return 1;
      return 0;
    });
    
    return pipelineStages;
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
      selectedPipeline.value = '';
      selectedPipelineId.value = '';
      selectedStage.value = '';
      selectedStageId.value = '';
      return;
    }

    selectedPipeline.value = pipelineName;
    selectedPipelineId.value = pipelineId;
    
    // Always set the default stage for the pipeline
    final defaultStage = getDefaultStageForPipeline(pipelineId);
    if (defaultStage != null) {
      selectedStage.value = defaultStage.stageName;
      selectedStageId.value = defaultStage.id;
    } else {
      // If no default stage found, get the first stage for this pipeline
      final pipelineStages = getStagesForPipeline(pipelineId);
      if (pipelineStages.isNotEmpty) {
        final firstStage = pipelineStages.first;
        selectedStage.value = firstStage.stageName;
        selectedStageId.value = firstStage.id;
      } else {
        selectedStage.value = '';
        selectedStageId.value = '';
      }
    }
  }

  Future<List> getLeads() async {
    try {
      isLoading.value = true;
      final data = await _leadService.getLeads();
      
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPipelines() async {
    try {
      isLoading.value = true;
      final pipelineList = await _pipelineService.getPipelines();
      pipelines.clear(); // Clear existing data
      pipelines.assignAll(pipelineList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch pipelines',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addLead() async {
    try {
      isLoading.value = true;
      
      // Collect all form data
      final Map<String, dynamic> leadData = {
        'leadTitle': leadTitleController.text,
        'leadStage': selectedStage.value,
        'pipeline': selectedPipeline.value,
        'currency': 'USD',
        'leadValue': int.tryParse(leadValueController.text) ?? 0,
        'source': getLabelId(selectedSource.value, 'source'),
        'category': getLabelId(selectedCategory.value, 'category'),
        'status': getLabelId(selectedStatus.value, 'status'),
        'interest_level': 'medium',
        'client_id': 'default',
        'created_by': 'default',
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'company': companyController.text,
        'address': addressController.text,
      };

      // Validate required fields
      if ((leadData['leadTitle'] as String?)?.isEmpty ?? true) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Lead title is required',
          contentType: ContentType.warning,
        );
        return;
      }

      if ((leadData['pipeline'] as String?)?.isEmpty ?? true) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Pipeline is required',
          contentType: ContentType.warning,
        );
        return;
      }

      if (leadData['leadValue'] == 0) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Lead value is required',
          contentType: ContentType.warning,
        );
        return;
      }

      if ((leadData['source'] as String?)?.isEmpty ?? true) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Validation Error',
          message: 'Source is required',
          contentType: ContentType.warning,
        );
        return;
      }

      final response = await _leadService.createLead(leadData);
      
      if (response.statusCode == 200) {
        // Clear form
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

        // Refresh all data
        await refreshData();
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Lead created successfully',
          contentType: ContentType.success,
        );
      } else {
        String errorMessage = 'Failed to create lead';
        String? serverMessage;
        
        try {
          final responseData = jsonDecode(response.body);
          if (responseData is Map) {
            serverMessage = responseData['message'] ?? responseData['error'];
          }
        } catch (e) {
          print('Error parsing response: $e');
        }
        
        // Handle specific error cases
        if (response.statusCode == 400) {
          errorMessage = serverMessage ?? 'Invalid lead data provided';
        } else if (response.statusCode == 401) {
          errorMessage = 'Unauthorized. Please login again';
        } else if (response.statusCode == 403) {
          errorMessage = 'You do not have permission to create leads';
        } else if (response.statusCode == 409) {
          errorMessage = 'A lead with this email already exists';
        } else if (response.statusCode == 500) {
          errorMessage = 'Server error. Please try again later';
        }

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: errorMessage,
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      String errorMessage = 'Failed to create lead';
      
      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection. Please check your network';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timed out. Please try again';
      } else if (e.toString().contains('FormatException')) {
        errorMessage = 'Invalid data format. Please check your input';
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: errorMessage,
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editLead(String leadId) async {
    try {
      final leadData = await _leadService.getLeadById(leadId);
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
      final isDeleted = await _leadService.deleteLead(id);
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

  // get label names for display
  String getSourceName(String id) {
    return _labelService.getSources(labels).firstWhere((e) => e.id == id, orElse: () => LabelModel(
      id: '',
      relatedId: '',
      labelType: 'source',
      name: '',
      color: '',
      clientId: '',
      createdBy: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )).name;
  }

  String getCategoryName(String id) {
    return _labelService.getCategories(labels).firstWhere((e) => e.id == id, orElse: () => LabelModel(
      id: '',
      relatedId: '',
      labelType: 'category',
      name: '',
      color: '',
      clientId: '',
      createdBy: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )).name;
  }

  String getStatusName(String id) {
    return _labelService.getStatuses(labels).firstWhere((e) => e.id == id, orElse: () => LabelModel(
      id: '',
      relatedId: '',
      labelType: 'status',
      name: '',
      color: '',
      clientId: '',
      createdBy: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )).name;
  }
}
