import 'dart:io';

import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/job/job_list/job_list_model.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_list/controllers/job_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../../../../../data/network/job/job_applications/job_application_service.dart';
import '../../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../users/controllers/users_controller.dart';

class JobApplicationController extends PaginatedController<JobApplicationData> {
  final JobApplicationService _service = JobApplicationService();
  final String url = UrlRes.jobApplications;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController totalExperienceController =
      TextEditingController();
  final TextEditingController currentLocationController =
      TextEditingController();
  final TextEditingController noticePeriodController = TextEditingController();
  final TextEditingController appliedSourceController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController cvPathController = TextEditingController();

  Rxn<CountryModel> selectedCountryCode = Rxn();
  RxList<CountryModel> countryCodes = <CountryModel>[].obs;
  final CountryController countryController = Get.put(CountryController());

  final RxList<JobData> jobPositions = <JobData>[].obs;
  final JobListController jobListController = Get.put(JobListController());
  final Rxn<JobData> selectedJobPosition = Rxn<JobData>();

  final List<String> experienceList = ["Entry Level","1-3 years","3-5 years","5-7 years","7+ years"];
  final RxString selectedExperience = ''.obs;

  final List<String> applicationStatus = ["pending","shortlisted","interviewed","selected","rejected"];
  final RxString selectedApplicationStatus = ''.obs;

  Rxn<File> selectedFile = Rxn<File>();

  @override
  Future<List<JobApplicationData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchJobApplications(page: page);
      print("Response: ${response?.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch job applications";
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
    loadJobs();
    loadCountries();
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    locationController.clear();
    totalExperienceController.clear();
    currentLocationController.clear();
    noticePeriodController.clear();
    appliedSourceController.clear();
    statusController.clear();
    cvPathController.clear();
    if (jobPositions.isNotEmpty) {
      selectedJobPosition.value = jobPositions.first;
    }
    selectedExperience.value = experienceList.first;
    if (applicationStatus.isNotEmpty) {
      selectedApplicationStatus.value = applicationStatus.first;
    }
  }

  Future<void> loadCountries() async {
    await countryController.getCountries();
    countryCodes.assignAll(countryController.countryModel);
    if (countryCodes.isNotEmpty) {
      selectedCountryCode.value = countryCodes.firstWhereOrNull(
        (element) => (element.countryName).toLowerCase() == "india",
      );
    }
  }

  Future<CountryModel> getCountryById(String id) async {
    try {
      final existingCountry = countryCodes.firstWhereOrNull(
        (item) => item.id == id,
      );
      if (existingCountry != null) {
        return existingCountry;
      } else {
        final country = await countryController.getCountryById(id);
        if (country != null) {
          countryCodes.add(country);
        }
        return country!;
      }
    } catch (e) {
      print("Create customer error: $e");
      return CountryModel(
        id: "",
        countryName: "",
        countryCode: "",
        phoneCode: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Load all managers for the current client
  // Future<void> loadManagers() async {
  //   try {
  //     final userData = await SecureStorage.getUserData();
  //     final clientId = userData?.id;
  //     if (clientId == null || clientId.isEmpty) {
  //       print("No client ID found for the current user.");
  //       return;
  //     }
  //
  //     final clientUsers = await usersController.getUsersByClientId(clientId);
  //     managers.assignAll(clientUsers);
  //
  //     if (managers.isNotEmpty && selectedManager.value == null) {
  //       selectedManager.value = managers.first;
  //     }
  //   } catch (e, stackTrace) {
  //     print("Error loading managers: $e");
  //     print(stackTrace);
  //   }
  // }
  //
  // Future<User?> getManagerById(String id) async {
  //   try {
  //     final user = await usersController.getUserById(id);
  //     if (user != null && !managers.any((m) => m.id == user.id)) {
  //       managers.add(user);
  //     }
  //     return user;
  //   } catch (e) {
  //     print("Error loading manager by ID: $e");
  //   }
  // }

  Future<void> loadJobs() async {
    try {
      await jobListController.loadInitial();
      if (jobListController.items.isNotEmpty) {
        jobPositions.assignAll(
          jobListController.items.map((item) => item).toList(),
        );
      }

      if (jobPositions.isNotEmpty && selectedJobPosition.value == null) {
        selectedJobPosition.value = jobPositions.first;
      }
    } catch (e, stackTrace) {
      print("Error loading jobs: $e");
      print(stackTrace);
    }
  }

  Future<JobData?> getJobById(String id) async {
    try {
      final user = await jobListController.getJobById(id);
      if (user != null && !jobPositions.any((m) => m.id == user.id)) {
        jobPositions.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading manager by ID: $e");
    }
  }

  Future<JobApplicationData?> getJobApplicationById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final application = await _service.getJobApplicationById(id);
        if (application != null) {
          items.add(application);
          items.refresh();
          return application;
        }
      }
    } catch (e) {
      print("Get job application error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createJobApplication(JobApplicationData application) async {
    try {
      if (selectedFile.value == null) {
        print("⚠️ No file selected for job application.");
        return false;
      }

      final success = await _service.createJobApplication(
        application,
        selectedFile.value!, // safe now
      );

      if (success) {
        await loadInitial(); // reload applications after create
      }
      return success;
    } catch (e, stackTrace) {
      print("Create job application error: $e");
      print(stackTrace);
      return false;
    }
  }


  Future<bool> updateJobApplication(
      String id,
      JobApplicationData updatedApplication,
      ) async {
    try {
      final success = await _service.updateJobApplication(
        id,
        updatedApplication,
        selectedFile.value, // pass only if file is selected
      );

      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedApplication;
          items.refresh();
        }
      }

      return success;
    } catch (e) {
      print("Update job application error: $e");
      return false;
    }
  }


  Future<bool> deleteJobApplication(String id) async {
    try {
      final success = await _service.deleteJobApplication(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete job application error: $e");
      return false;
    }
  }
}
