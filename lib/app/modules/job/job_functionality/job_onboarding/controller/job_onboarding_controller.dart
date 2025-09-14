import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/system/currency/service/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/job/job_onboarding/job_onboarding_model.dart';
import '../../../../../data/network/job/job_onboarding/job_onboarding_service.dart';
import '../../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../users/controllers/users_controller.dart';


class JobOnboardingController extends PaginatedController<JobOnboardingData> {
  final JobOnboardingService _service = JobOnboardingService();
  final CurrencyService _currencyService = CurrencyService();
  final String url = UrlRes.jobOnboarding;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController interviewerController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  Rxn<DateTime> selectedJoiningDate = Rxn<DateTime>();
  final TextEditingController daysOfWeekController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();


  final List<String> salaryTypeList = ["Monthly","Annual" ,"Weekly","Hourly"];
  final RxString selectedSalaryType = "".obs;

  final List<String> salaryDurationList = ["Monthly","Annual" ,"Weekly","Hourly"];
  final RxString selectedSalaryDuration = "".obs;

  final List<String> jobTypeList = ["Full-Time", "Part-Time", "Contract"];
  final RxString selectedJobType = "".obs;

  final List<String> statusList =["Pending", "In Progress", "Completed","Delayed"];
  final RxString selectedStatus = "".obs;

  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;


  final RxList<User> managers = <User>[].obs;
  final UsersController usersController = Get.put(UsersController());
  Rxn<User> selectedManager = Rxn<User>();

  @override
  Future<List<JobOnboardingData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchJobOnboardings(page: page);
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch job onboardings";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    loadManagers();
    loadCurrencies();
  }

  void resetForm() {
    interviewerController.clear();
    joiningDateController.clear();
    daysOfWeekController.clear();
    salaryController.clear();
    selectedJoiningDate.value = null;
    joiningDateController.clear();
   selectedSalaryType.value = salaryTypeList.first;
   selectedSalaryDuration.value = salaryDurationList.first;
   selectedJobType.value = jobTypeList.first;
   selectedStatus.value = statusList.first;
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

  /// Load all managers for the current client
  Future<void> loadManagers() async {
    try {
      final userData = await SecureStorage.getUserData();
      final clientId = userData?.id;
      if (clientId == null || clientId.isEmpty) {
        print("No client ID found for the current user.");
        return;
      }

      final clientUsers = await usersController.getUsersByClientId(clientId);
      managers.assignAll(clientUsers);

      print("Managers loaded: ${managers.length}");

      if (managers.isNotEmpty && selectedManager.value == null) {
        selectedManager.value = managers.first;
      }
    } catch (e, stackTrace) {
      print("Error loading managers: $e");
      print(stackTrace);
    }
  }

  /// Load a specific manager by ID if not already in the list
  Future<User?> getManagerById(String id) async {
    try {
      final user = await usersController.getUserById(id);
      if (user != null && !managers.any((m) => m.id == user.id)) {
        managers.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading manager by ID: $e");
    }
    return null;
  }

  /// Get single job onboarding by ID
  Future<JobOnboardingData?> getJobOnboardingById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final job = await _service.getJobOnboardingById(id);
        if (job != null) {
          items.add(job);
          items.refresh();
          return job;
        }
      }
    } catch (e) {
      print("Get job onboarding error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createJobOnboarding(JobOnboardingData job) async {
    try {
      final success = await _service.createJobOnboarding(job);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create job onboarding error: $e");
      return false;
    }
  }

  Future<bool> updateJobOnboarding(String id, JobOnboardingData updatedJob) async {
    try {
      final success = await _service.updateJobOnboarding(id, updatedJob);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedJob;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update job onboarding error: $e");
      return false;
    }
  }

  Future<bool> deleteJobOnboarding(String id) async {
    try {
      final success = await _service.deleteJobOnboarding(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete job onboarding error: $e");
      return false;
    }
  }
}
