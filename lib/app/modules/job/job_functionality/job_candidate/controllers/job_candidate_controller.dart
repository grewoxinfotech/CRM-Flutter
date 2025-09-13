import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/job/job_candidate/job_candidate_model.dart';
import '../../../../../data/network/job/job_candidate/job_candidate_service.dart';

class JobCandidateController extends PaginatedController<JobCandidateData> {
  final JobCandidateService _service = JobCandidateService();
  final String url = UrlRes.jobCandidates;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  /// Candidate form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController noticePeriodController = TextEditingController();

  final Rxn<String> selectedStatus = Rxn<String>();
  final Rxn<String> selectedJob = Rxn<String>();

  @override
  Future<List<JobCandidateData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchCandidates(page: page);
      print("Response: ${response?.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch candidates";
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
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    locationController.clear();
    experienceController.clear();
    noticePeriodController.clear();
    selectedStatus.value = null;
    selectedJob.value = null;
  }

  /// Get single candidate by ID
  Future<JobCandidateData?> getCandidateById(String id) async {
    try {
      final existingCandidate = items.firstWhereOrNull((item) => item.id == id);
      if (existingCandidate != null) {
        return existingCandidate;
      } else {
        final candidate = await _service.getCandidateById(id);
        if (candidate != null) {
          items.add(candidate);
          items.refresh();
          return candidate;
        }
      }
    } catch (e) {
      print("Get candidate error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---

  Future<bool> createCandidate(JobCandidateData candidate) async {
    try {
      final success = await _service.createCandidate(candidate);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create candidate error: $e");
      return false;
    }
  }

  Future<bool> updateCandidate(
    String id,
    JobCandidateData updatedCandidate,
  ) async {
    try {
      final success = await _service.updateCandidate(id, updatedCandidate);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedCandidate;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update candidate error: $e");
      return false;
    }
  }

  Future<bool> deleteCandidate(String id) async {
    try {
      final success = await _service.deleteCandidate(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete candidate error: $e");
      return false;
    }
  }
}
