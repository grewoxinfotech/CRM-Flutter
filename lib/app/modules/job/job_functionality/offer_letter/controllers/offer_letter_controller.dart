import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_applications/controllers/job_application_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/job/offer_letter/offer_letter_model.dart';
import '../../../../../data/network/job/offer_letter/offer_letter_service.dart';
import '../../../../../data/network/system/currency/model/currency_model.dart';
import '../../../../../data/network/system/currency/service/currency_service.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../job_list/controllers/job_list_controller.dart';


class OfferLetterController extends PaginatedController<OfferLetterData> {
  final OfferLetterService _service = OfferLetterService();
  final CurrencyService _currencyService = CurrencyService();
  final String url = UrlRes.offerLetters;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Selected values
  final TextEditingController offerExpiryController = TextEditingController();
  Rxn<DateTime> offerExpiry = Rxn<DateTime>();
  final TextEditingController expectedJoiningDateController = TextEditingController();
  Rxn<DateTime> expectedJoiningDate = Rxn<DateTime>();

  final RxList<JobData> jobPositions = <JobData>[].obs;
  final JobListController jobListController = Get.put(JobListController());
  final Rxn<JobData> selectedJobPosition = Rxn<JobData>();

  final RxList<JobApplicationData> jobApplications = <JobApplicationData>[].obs;
  final JobApplicationController jobApplicationController = Get.put(JobApplicationController());
  final Rxn<JobApplicationData> selectedJobApplication = Rxn<JobApplicationData>();

  Rxn<File> selectedFile = Rxn<File>();

  RxString currency = 'AHNTpSNJHMypuNF6iPcMLrz'.obs;
  RxString currencyCode = 'INR'.obs;
  RxString currencyIcon = '₹'.obs;
  var currencies = <CurrencyModel>[].obs;
  var isLoadingCurrencies = false.obs;
  var currenciesLoaded = false.obs;

  @override
  Future<List<OfferLetterData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchOfferLetters(page: page);
      print("Response: ${response?.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch offer letters";
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
    loadJobs();
    loadJobApplications();
    loadCurrencies();
    loadInitial();
  }

  void resetForm() {
    if(jobPositions.isNotEmpty){
      selectedJobPosition.value = jobPositions.first;
    }
    if(jobApplications.isNotEmpty){
      selectedJobApplication.value = jobApplications.first;
    }

    offerExpiryController.clear();
    expectedJoiningDateController.clear();
    salaryController.clear();
    descriptionController.clear();

    offerExpiry.value = null;
    expectedJoiningDate.value = null;
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

  Future<void> loadJobApplications() async {
    try {
      await jobApplicationController.loadInitial();
      if (jobApplicationController.items.isNotEmpty) {
        jobApplications.assignAll(
          jobApplicationController.items.map((item) => item).toList(),
        );
      }

      if (jobApplications.isNotEmpty && selectedJobApplication.value == null) {
        selectedJobApplication.value = jobApplications.first;
      }
    } catch (e, stackTrace) {
      print("Error loading job Application: $e");
      print(stackTrace);
    }
  }

  Future<JobApplicationData?> getJobApplicationById(String id) async {
    try {
      final user = await jobApplicationController.getJobApplicationById(id);
      if (user != null && !jobApplications.any((m) => m.id == user.id)) {
        jobApplications.add(user);
      }
      return user;
    } catch (e) {
      print("Error loading job Application by ID: $e");
    }
  }

  /// Get single offer letter by ID
  Future<OfferLetterData?> getOfferLetterById(String id) async {
    try {
      final existingOffer = items.firstWhereOrNull((item) => item.id == id);
      if (existingOffer != null) {
        return existingOffer;
      } else {
        final offerLetter = await _service.getOfferLetterById(id);
        if (offerLetter != null) {
          items.add(offerLetter);
          items.refresh();
          return offerLetter;
        }
      }
    } catch (e) {
      print("Get offer letter error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createOfferLetter(OfferLetterData offerLetter) async {
    try {
      isLoading.value = true; // show loader
      final success = await _service.createOfferLetter(
        offerLetter,
        selectedFile.value,
      );

      if (success) {
        await loadInitial(); // refresh list after success
      }

      return success;
    } catch (e) {
      print("Create offer letter error: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong while creating offer letter",
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false; // hide loader
    }
  }


  Future<bool> updateOfferLetter(String id, OfferLetterData updatedOffer,File? file) async {
    try {
      isLoading.value = true; // optional loader state

      final success = await _service.updateOfferLetter(
        id,
        updatedOffer,
        file,
      );

      if (success) {
        final index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          // Preserve the updated file if needed
          updatedOffer.id = id;
          updatedOffer.file = file != null ? file.path : items[index].file;
          items[index] = updatedOffer;
          items.refresh();
        }
      }

      return success;
    } catch (e) {
      print("Update offer letter error: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong while updating the offer letter",
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteOfferLetter(String id) async {
    try {
      final success = await _service.deleteOfferLetter(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete offer letter error: $e");
      return false;
    }
  }
}
