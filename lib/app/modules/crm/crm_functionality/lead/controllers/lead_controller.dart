import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/model/pipeline_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/service/pipeline_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/model/stage_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/service/stage_service.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/lead/service/lead_service.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/service/currency_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../activity/controller/activity_controller.dart';

class LeadController extends PaginatedController<LeadData> {
  // Services
  final _leadService = LeadService();
  final _stageService = StageService();
  final _pipelineService = PipelineService();
  final _currencyService = CurrencyService();

  // Controllers
  late ActivityController activityController;
  late CurrencyController currencyController;
  final _usersController = Get.find<UsersController>();
  final _roleController = Get.find<RoleController>();
  late final StageController stageController;
  late final PipelineController pipelineController;
  late final LabelController labelController;

  // State variables
  // final leads = <LeadData>[].obs;
  final stages = <StageModel>[].obs;
  final pipelines = <PipelineModel>[].obs;
  // final currency = <CurrencyModel>[].obs;
  final labels = <LabelModel>[].obs;
  final users = <User>[].obs;

  // Form controllers
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

  // Dropdown selections
  final selectedPipeline = Rxn<String>();
  final selectedPipelineId = Rxn<String>();
  final selectCurrency = Rxn<String>();
  final selectedSource = Rxn<String>();
  final selectedCategory = Rxn<String>();
  final selectedInterestLevel = Rxn<String>();
  final selectedStage = Rxn<String>();
  final selectedStageId = Rxn<String>();
  final selectedStatus = Rxn<String>();
  final selectedNoteType = Rxn<String>();
  final selectedContact = Rxn<String>();

  // Loading states
  final isLoading = false.obs;
  final isCreating = false.obs;
  final isUpdating = false.obs;
  final isDeleting = false.obs;
  final isError = ''.obs;
  var errorMessage = ''.obs;

  RxString userId = ''.obs;

  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  // Getters for dropdown options with label names

  // Get source options from labels
  List<Map<String, String>> get sourceOptions {
    try {
      if (labelController == null) return [];
      final sources = labelController.getSources();
      return sources
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get category options from labels
  List<Map<String, String>> get categoryOptions {
    try {
      if (labelController == null) return [];
      final categories = labelController.getCategories();
      return categories
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get status options from labels
  List<Map<String, String>> get statusOptions {
    try {
      if (labelController == null) return [];
      final statuses = labelController.getStatuses();
      return statuses
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (e) {
      return [];
    }
  }

  List<String> get interestLevelOptions => ['low', 'medium', 'high'];

  // Get label name by ID or name
  String getLabelName(String labelIdOrName) {
    try {
      if (labelController == null) return '';
      if (labelIdOrName.isEmpty) return '';

      return labelController.getLabelName(labelIdOrName);
    } catch (e) {
      return labelIdOrName;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
    // Initialize controllers
    activityController = Get.put(ActivityController());
    stageController = Get.put(StageController());
    pipelineController = Get.put(PipelineController());

    // Initialize LabelController first to avoid late initialization error
    try {
      if (!Get.isRegistered<LabelController>()) {
        labelController = Get.put(LabelController());
      } else {
        labelController = Get.find<LabelController>();
      }
    } catch (e) {
      // Fallback if there's an issue with LabelController
      labelController = Get.put(LabelController());
    }

    _initializeData();
    refreshData();

    loadCurrencies();
  }

  Future<void> getCurrentUser() async {
    final user = await SecureStorage.getUserData();
    if (user != null) {
      userId.value = user.id!;
    }
  }

  Future<void> loadCurrencies() async {
    try {
      final currencyList = await _currencyService.getCurrencies();
      currencies.assignAll(currencyList);
      currenciesLoaded.value = true;

      if (currencyList.isNotEmpty) {
        final selectedCurrency = currencyList.firstWhereOrNull(
          (c) => c.id == currency.value,
        );

        if (selectedCurrency != null) {
          currencyCode.value = selectedCurrency.currencyCode;
          currencyIcon.value = selectedCurrency.currencyIcon;
        } else {
          currency.value = currencyList.first.id;
          currencyCode.value = currencyList.first.currencyCode;
          currencyIcon.value = currencyList.first.currencyIcon;
        }
      }
    } catch (e) {
      if (currenciesLoaded.value) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to load currencies: ${e.toString()}',
          contentType: ContentType.failure,
        );
      }
    } finally {
      isLoadingCurrencies.value = false;
    }
  }

  void updateCurrencyDetails(String currencyId) {
    if (currencies.isNotEmpty) {
      final selectedCurrency = currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );

      if (selectedCurrency != null) {
        currency.value = currencyId;
        currencyCode.value = selectedCurrency.currencyCode;
        currencyIcon.value = selectedCurrency.currencyIcon;
      }
    }
  }

  Future<void> _initializeData() async {
    await Future.wait([loadInitial(), fetchLabels(), fetchUsers()]);
  }

  Future<void> fetchLabels() async {
    try {
      // Make sure labelController is initialized
      if (labelController == null) {
        if (!Get.isRegistered<LabelController>()) {
          labelController = Get.put(LabelController());
        } else {
          labelController = Get.find<LabelController>();
        }
      }

      // Use the label controller to fetch labels
      await labelController.getLabels();
    } catch (e) {
      _showErrorSnackbar('Failed to fetch labels', e);
    }
  }

  // Future<void> fetchLeads() async {
  //   try {
  //     isLoading(true);
  //     final fetchedLeads = await _leadService.fetchLeads();
  //     leads.assignAll(fetchedLeads);
  //   } catch (e) {
  //     _showErrorSnackbar('Failed to fetch leads', e);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  Future<List<LeadData>> fetchItems(int page) async {
    try {
      final response = await _leadService.fetchLeads(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch revenues";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  Future<LeadData?> getLeadById(String id) async {
    try {
      isLoading(true);
      return await _leadService.getLeadById(id);
    } catch (e) {
      _showErrorSnackbar('Failed to fetch lead', e);
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> createLead(LeadData lead) async {
    try {
      isCreating(true);
      final response = await _leadService.createLead(lead);

      if (response) {
        await loadInitial();
        _showSuccessSnackbar('Lead created successfully');
        return true;
      }
      return false;
    } catch (e) {
      _showErrorSnackbar('Failed to create lead', e);
      return false;
    } finally {
      isCreating(false);
    }
  }

  Future<bool> updateLead(String id, LeadData lead) async {
    try {
      isUpdating(true);

      final response = await _leadService.updateLead(id, lead.toJson());
      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        await loadInitial();
        _showSuccessSnackbar('Lead updated successfully');
        return true;
      } else {
        _showErrorSnackbar(
          'Failed to update lead',
          'Status code: ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      _showErrorSnackbar('Failed to update lead', e);
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> deleteLead(String id) async {
    try {
      isDeleting(true);
      final success = await _leadService.deleteLead(id);

      if (success) {
        items.removeWhere((lead) => lead.id == id);
        _showSuccessSnackbar('Lead deleted successfully');
        return true;
      }
      return false;
    } catch (e) {
      _showErrorSnackbar('Failed to delete lead', e);
      return false;
    } finally {
      isDeleting(false);
    }
  }

  // Fetch lead members with comprehensive user data
  Future<LeadData> fetchLeadMembers(LeadData lead) async {
    if (lead.leadMembers == null ||
        (lead.leadMembers!.leadMembers?.isEmpty ?? true)) {
      return lead;
    }

    try {
      // Use the UsersController to get users
      if (_usersController.users.isEmpty) {
        await fetchUsers();
      }

      List<String> memberIds = lead.leadMembers?.leadMembers ?? [];

      if (memberIds.isEmpty) {
        return lead;
      }

      List<User> foundUsers = [];
      List<String> missingUserIds = [];

      for (String memberId in memberIds) {
        final user = _usersController.getUserById(memberId);
        if (user != null) {
          foundUsers.add(user);
        } else {
          missingUserIds.add(memberId);
        }
      }

      return lead;
    } catch (e) {
      return lead;
    }
  }

  Future<void> fetchUsers() async {
    try {
      // Use the UsersController to fetch users
      await _usersController.fetchUsers();
      users.assignAll(_usersController.users);
    } catch (e) {
      _showErrorSnackbar('Failed to fetch users', e);
    }
  }

  // Get a list of users by member IDs
  List<User> getLeadMembers(List<String> memberIds) {
    return memberIds
        .map((id) => _usersController.getUserById(id))
        .whereType<User>()
        .toList();
  }

  // Get role name by ID
  String getRoleName(String roleId) {
    return _roleController.getRoleName(roleId);
  }

  // Check if a user has a specific permission
  bool hasPermission(
    String roleId,
    String permissionKey,
    String permissionType,
  ) {
    return _roleController.hasPermission(roleId, permissionKey, permissionType);
  }

  // Ensure users are loaded for the members tab
  Future<bool> ensureUsersLoaded() async {
    try {
      if (users.isEmpty) {
        await fetchUsers();
      }
      return true;
    } catch (e) {
      _showErrorSnackbar('Failed to load users', e);
      return false;
    }
  }

  String getStageName(String stageIdOrName) {
    return stageController.getStageName(stageIdOrName);
  }

  String getPipelineName(String pipelineIdOrName) {
    return pipelineController.getPipelineName(pipelineIdOrName);
  }

  Future<void> refreshData() async {
    isLoading(true);
    try {
      await Future.wait([loadInitial(), fetchLabels(), fetchUsers()]);
    } catch (e) {
      _showErrorSnackbar('Failed to refresh data', e);
    } finally {
      isLoading(false);
    }
  }

  List<LeadData> getLeadsByCustomerId(String customerId) {
    return items
        .where((lead) => lead.contactId?.trim() == customerId.trim())
        .toList();
  }

  List<LeadData> getLeadsByCompanyId(String companyId) {
    return items
        .where((lead) => lead.companyId?.trim() == companyId.trim())
        .toList();
  }

  // Helper methods for showing snackbars
  void _showSuccessSnackbar(String message) {
    // Defer showing snackbar to avoid build-time errors
    Future.microtask(() {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Success',
        message: message,
        contentType: ContentType.success,
      );
    });
  }

  void _showErrorSnackbar(String message, dynamic error) {
    // Defer showing snackbar to avoid build-time errors
    Future.microtask(() {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: '$message: ${error.toString()}',
        contentType: ContentType.failure,
      );
    });
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


}
