
import 'dart:convert';
import 'package:crm_flutter/app/data/network/crm/company/model/company_model.dart';
import 'package:crm_flutter/app/data/network/crm/company/service/company_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/activity/controller/activity_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/company/controller/company_controller.dart';
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
import 'package:intl/intl.dart';

import '../../../../../care/pagination/controller/pagination_controller.dart';
import '../../../../../data/network/crm/crm_system/label/controller/label_controller.dart';
import '../../../../../data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import '../../../../../data/network/crm/crm_system/stage/controller/stage_controller.dart';
import '../../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';

class DealController extends PaginatedController<DealData> {
  final RxBool isLoading = false.obs;

  // Services
  final DealService dealService = DealService();
  final StageService stageService = StageService();
  final PipelineService pipelineService = PipelineService();
  final LabelService labelService = LabelService();
  final AllUsersService allUsersService = AllUsersService();
  final NoteService noteService = NoteService();
  final CurrencyService _currencyService = CurrencyService();
  final CompanyService _companyService = CompanyService();

  // Controllers
  late final ActivityController activityController;

  // State Variables
  // final RxList<DealData> deal = <DealData>[].obs;
  final RxList<StageModel> stages = <StageModel>[].obs;
  final RxList<PipelineModel> pipelines = <PipelineModel>[].obs;
  final RxList<CompanyData> companies = <CompanyData>[].obs;
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
  final endDateController = TextEditingController();
  final products = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final companyName = TextEditingController();
  final address = TextEditingController();
  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();

  late final LabelController labelController;
  final StageController stageController = Get.put(StageController());
  final CompanyController companyController = Get.put(CompanyController());
  final PipelineController pipelineController = Get.put(PipelineController());
  final CountryController countryController = Get.put(CountryController());

  // Dropdown Selections
  final selectedPipeline = ''.obs;
  final selectedPipelineId = ''.obs;
  final selectedSource = ''.obs;
  final selectedCategory = ''.obs;
  final selectedEndDate = Rxn<DateTime>();
  final selectedCompany = ''.obs;
  final selectedContact = ''.obs;
  final selectedStage = ''.obs;
  final selectedStageId = ''.obs;
  final selectedStatus = ''.obs;
  final selectedLeadId = ''.obs;
  Rxn<CountryModel> selectedCountryCode = Rxn<CountryModel>();

  final isCreating = false.obs;

  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  final isSelectFromExisting = false.obs;
  final isSelectCompanyAndContact = false.obs;

  var errorMessage = ''.obs;

  // -------------------- PAGINATION --------------------
  @override
  Future<List<DealData>> fetchItems(int page) async {
    try {
      final response = await dealService.fetchDeals(page: page);
      print("Response: ${response!.toJson()}");
      if (response.success == true) {
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


  // -------------------- REST OF ORIGINAL CODE --------------------
  Future<void> loadCompanies() async {
    try {
      await companyController.loadInitial();
      companies.assignAll(companyController.items);
      if (companies.isNotEmpty) {
        selectedCompany.value = companies.value.first.id!;
      }
    } catch (e) {
      print("Error loading companies: $e");
    }
  }

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

  @override
  void onInit() {
    super.onInit();
    activityController = Get.put(ActivityController());
    try {
      if (!Get.isRegistered<LabelController>()) {
        labelController = Get.put(LabelController());
      } else {
        labelController = Get.find<LabelController>();
      }
    } catch (e) {
      labelController = Get.put(LabelController());
    }
    loadInitial();
    refreshData();
    loadCurrencies();
    loadCompanies();
  }

  Future<DealData?> createDeal(DealData deal) async {
    try {
      isCreating(true);
      final createdDeal = await dealService.createDeal(deal);
      if (createdDeal != null) {
        await loadInitial();
        _showSuccessSnackbar('Deal created successfully');
        return createdDeal;
      }
      return null;
    } catch (e) {
      _showErrorSnackbar('Failed to create deal', e);
      return null;
    } finally {
      isCreating(false);
    }
  }

  void _showSuccessSnackbar(String message) {
    Future.microtask(() {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Success',
        message: message,
        contentType: ContentType.success,
      );
    });
  }

  void _showErrorSnackbar(String message, dynamic error) {
    Future.microtask(() {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: '$message: ${error.toString()}',
        contentType: ContentType.failure,
      );
    });
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

  Future<void> resetForm() async {
    dealTitle.clear();
    selectedCompany.value = '';
    selectedContact.value = '';
    firstName.clear();
    lastName.clear();
    email.clear();
    phoneNumber.clear();
    address.clear();
    dealValue.text = 0.toString();
    selectedEndDate.value = DateTime.now();
    endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    pipelineController.getPipelines().then((_) {
      if (pipelineController.pipelines.isNotEmpty) {
        selectedPipelineId.value = pipelineController.pipelines.first.id!;
        stageController.getStagesByPipeline(selectedPipelineId.value!);
      }
    });
    stageController.getStages().then((_) {
      if (stageController.stages.isNotEmpty) {
        final stage = stageController.stages.firstWhereOrNull(
          (stage) => (stage.stageName).toLowerCase() == "new deal",
        );
        selectedStageId.value = stage!.id;
      }
    });
    countryController.getCountries().then((_) {
      if (countryController.countryModel.isNotEmpty) {
        selectedCountryCode.value = countryController.countryModel.first;
      }
    });

    if (sourceOptions.isNotEmpty)
      selectedSource.value = sourceOptions.first['id']!;
    if (categoryOptions.isNotEmpty)
      selectedCategory.value = categoryOptions.first['id']!;
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await getLabels();
      await Future.wait([
        loadInitial(),
        getPipelines(),
        getStages(),
        getAllUsers(),
      ]);
    } catch (e) {

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

  Future<void> getAllUsers() async {
    try {
      isLoading.value = true;
      final usersList = await allUsersService.getUsers();

      if (usersList.isNotEmpty) {
        users.assignAll(usersList);
        print('Successfully loaded ${usersList.length} users');
      } else {
        print('Warning: No users returned from API');
      }
    } catch (e) {
      print('Error in getAllUsers: ${e.toString()}');

    } finally {
      isLoading.value = false;
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

  Future<void> getDealById(String dealId) async {
    try {
      final dealData = await dealService.getDealById(dealId);
      if (dealData != null) {
        final index = items.indexWhere((d) => d.id == dealId);
        if (index != -1) {
          items[index] = dealData;
          items.refresh();
          update();
        } else {
          await loadInitial();
        }
      }
    } catch (e) {
      await loadInitial();
    }
  }

  List<User> getDealMembers(List<String> memberIds) {
    try {
      if (memberIds.isEmpty) return [];

      // If users list is empty, try to load them first
      if (users.isEmpty) {
        getAllUsers();
        return []; // Return empty list for now, will be updated when users are loaded
      }

      // Filter users by memberIds
      final memberUsers =
          users.where((user) => memberIds.contains(user.id)).toList();

      // If no users found but we have memberIds, this might indicate a data issue
      if (memberUsers.isEmpty && memberIds.isNotEmpty) {
        print('Warning: No users found for member IDs: $memberIds');
      }

      return memberUsers;
    } catch (e) {
      print('Error getting deal members: $e');
      return [];
    }
  }

  Future<bool> deleteDeal(String id) async {
    try {
      final isDeleted = await dealService.deleteDeal(id);
      if (isDeleted) {
        await loadInitial();
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

  String getPipelineName(String pipelineIdOrName) {
    return pipelineController.getPipelineName(pipelineIdOrName);
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
    // selectedStageId.value = '';
  }

  Future<bool> updateDeal(String dealId, DealData data) async {
    try {
      isLoading.value = true;

      // final data = {


      final response = await dealService.updateDeal(dealId, data);
      if (response) {
        await refreshData();
        Get.back();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  List<DealData> getDealsByCustomerId(String customerId) {
    return items
        .where((deal) => deal.contactId?.trim() == customerId.trim())
        .toList();
  }

  List<DealData> getDealsByCompanyId(String companyId) {
    return items
        .where((deal) => deal.companyId?.trim() == companyId.trim())
        .toList();
  }

  // -------------------- Other existing methods (delete, edit, update, helpers) --------------------
  // Keep all of your other methods (getDealById, editDeal, updateDeal, getDealsByCompanyId, etc.) intact
  // No changes are required in them

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
