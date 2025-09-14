// import 'package:get/get.dart';
// import '../../../../../data/network/job/job_list/job_list_model.dart';
// import '../../../../../data/network/job/job_list/job_list_service.dart';
//
// class JobListController extends GetxController {
//   final JobListService _jobService = JobListService();
//
//   /// Observables
//   var jobs = <JobData>[].obs;
//   var isLoading = false.obs;
//   var pagination = Pagination().obs;
//
//   /// Fetch jobs with pagination & search
//   Future<void> fetchJobs({
//     int page = 1,
//     int pageSize = 10,
//     String search = '',
//   }) async {
//     try {
//       isLoading.value = true;
//       final response = await _jobService.fetchJobs(
//         page: page,
//         pageSize: pageSize,
//         search: search,
//       );
//
//       if (response != null && response.message?.data != null) {
//         jobs.value = response.message!.data!;
//         pagination.value = response.message?.pagination ?? Pagination();
//       }
//     } catch (e) {
//       print("Fetch jobs exception: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Get single job by ID
//   Future<JobData?> getJobById(String id) async {
//     try {
//       return await _jobService.getJobById(id);
//     } catch (e) {
//       print("Get job by ID exception: $e");
//       return null;
//     }
//   }
//
//   /// Create job
//   Future<bool> createJob(JobData job) async {
//     final success = await _jobService.createJob(job);
//     if (success) {
//       await fetchJobs(); // refresh list
//     }
//     return success;
//   }
//
//   /// Update job
//   Future<bool> updateJob(String id, JobData job) async {
//     final success = await _jobService.updateJob(id, job);
//     if (success) {
//       await fetchJobs(); // refresh list
//     }
//     return success;
//   }
//
//   /// Delete job
//   Future<bool> deleteJob(String id) async {
//     final success = await _jobService.deleteJob(id);
//     if (success) {
//       jobs.removeWhere((job) => job.id == id);
//     }
//     return success;
//   }
// }
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/system/currency/model/currency_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/job/job_list/job_list_service.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../users/controllers/users_controller.dart';
import '../../../../../data/database/storage/secure_storage_service.dart';

class JobListController extends PaginatedController<JobData> {
  final JobListService _jobService = JobListService();
  final UsersController usersController = Get.put(UsersController());
  final CurrencyService _currencyService = CurrencyService();
  final errorMessage = ''.obs;



  /// --- Form ---
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  // final TextEditingController skillsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final TextEditingController totalOpeningsController = TextEditingController();
  // final TextEditingController workExperienceController = TextEditingController();
  final TextEditingController expectedSalaryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// --- Dropdown values ---
  // final RxList<User> recruiters = <User>[].obs;
  // final Rxn<User> selectedRecruiter = Rxn<User>();

  // final RxList<CurrencyModel> currencies = <CurrencyModel>[].obs;
  // final Rxn<String> selectedCurrency = Rxn<String>();

  final List<String> jobStatusList = ["active", "inactive"];
  final Rxn<String> selectedStatus = Rxn<String>("inactive");
  final List<String> jobTypeList = ["Full-time", "Part-time", "Contract","temporary","internship"];
  final Rxn<String> selectedJobType = Rxn<String>("Full-time");

  final RxList<String> skillsList = <String>[].obs;
  final TextEditingController skillTextController = TextEditingController();
  final FocusNode skillFocusNode = FocusNode();

  final RxList<String> interviewRoundsList = <String>[].obs;
  final TextEditingController interviewRoundsController = TextEditingController();
  final FocusNode interviewRoundsFocus = FocusNode();

  final List<String> workExperienceList = ["Entry Level","1-3 years","3-5 years","5-7 years","7+ years"];
  final RxString selectedWorkExperience = ''.obs;

  final RxList<User> managers = <User>[].obs;
  Rxn<User> selectedManager = Rxn<User>();

  final TextEditingController startDateController = TextEditingController();
  Rxn<DateTime> selectedStartDate = Rxn<DateTime>();
  final TextEditingController endDateController = TextEditingController();
  Rxn<DateTime> selectedEndDate = Rxn<DateTime>();

  // final Rxn<String> selectedCurrency = Rxn<String>();
  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  void addSkill() {
    final skill = skillTextController.text.trim();
    if (skill.isNotEmpty && !skillsList.contains(skill)) {
      skillsList.add(skill);
    }
    skillTextController.clear();
  }

  void removeSkill(String skill) {
    skillsList.remove(skill);
  }



  @override
  void onInit() {
    super.onInit();
   loadInitial();
    loadCurrencies();
    loadManagers();
  }

  /// Fetch jobs with pagination & search
  // Future<void> fetchJobs({
  //   int page = 1,
  //   int pageSize = 10,
  //   String search = '',
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     final response = await _jobService.fetchJobs(
  //       page: page,
  //       pageSize: pageSize,
  //       search: search,
  //     );
  //
  //     if (response != null && response.message?.data != null) {
  //       jobs.value = response.message!.data!;
  //       pagination.value = response.message?.pagination ?? Pagination();
  //     }
  //   } catch (e) {
  //     print("Fetch jobs exception: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  Future<List<JobData>> fetchItems(int page) async {
    try {
      final response = await _jobService.fetchJobs(page: page);
      print("Response: ${response?.toJson()}");

      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;

        // ✅ Correct place to get jobs
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch jobs";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
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
  }


  /// Get single job by ID
  Future<JobData?> getJobById(String id) async {
    try {
      return await _jobService.getJobById(id);
    } catch (e) {
      print("Get job by ID exception: $e");
      return null;
    }
  }

  /// Create job
  Future<bool> createJob(JobData job) async {
    final success = await _jobService.createJob(job);
    if (success) {
      await loadInitial(); // refresh list
    }
    return success;
  }

  /// Update job
  Future<bool> updateJob(String id, JobData job) async {
    final success = await _jobService.updateJob(id, job);
    if (success) {
      int index = items.indexWhere((item) => item.id == id);
      if (index != -1) {
        items[index] = job;
        items.refresh();
      }
    }
    return success;
  }

  /// Delete job
  Future<bool> deleteJob(String id) async {
    final success = await _jobService.deleteJob(id);
    if (success) {
      items.removeWhere((job) => job.id == id);
    }
    return success;
  }


  /// --- Helpers ---
  void resetForm() {
    titleController.clear();
    categoryController.clear();
    skillTextController.clear();
    locationController.clear();
    interviewRoundsController.clear();
    startDateController.clear();
    endDateController.clear();
    totalOpeningsController.clear();
    expectedSalaryController.clear();
    descriptionController.clear();

    skillsList.clear();
    // skillFocusNode.dispose();
    // interviewRoundsFocus.dispose();
   if(managers.isNotEmpty){
     selectedManager.value = managers.first;
   }
    interviewRoundsList.clear();
    selectedStatus.value = jobStatusList.first;
    selectedJobType.value = jobTypeList.first;
    currency.value = currencies.first.id;
    currencyCode.value = currencies.first.currencyCode;
    currencyIcon.value = currencies.first.currencyIcon;
    selectedWorkExperience.value = workExperienceList.first;
  }


}
