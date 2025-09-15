import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../../../data/network/hrm/hrm_system/designation/designation_model.dart';
import '../../../../data/network/hrm/hrm_system/designation/designation_service.dart';

class DesignationController extends PaginatedController<DesignationData> {
  final DesignationService _service = DesignationService();
  final String url = UrlRes.designations;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController designationNameController =
      TextEditingController();

  // --- BRANCHES ---
  final RxList<BranchData> branches = <BranchData>[].obs;
  final BranchController branchController = Get.put(BranchController());
  RxnString selectedBranch = RxnString();

  @override
  Future<List<DesignationData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchDesignations(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Designation";
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
    _loadBranches();
  }

  void resetForm() {
    designationNameController.clear();
    selectedBranch.value = null;
    if (branches.isNotEmpty) {
      selectedBranch.value = branches.first.id;
    }
  }

  void _loadBranches() async {
    try {
      await branchController.loadInitial(); // fetches branches
      branches.assignAll(branchController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  /// Get single designation by ID
  Future<DesignationData?> getDesignationById(String id) async {
    try {
      await loadInitial();
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final designation = await _service.getDesignationById(id);
        if (designation != null) {
          items.add(designation);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get designation error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createDesignation(DesignationData designation) async {
    try {
      final success = await _service.createDesignation(designation);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create designation error: $e");
      return false;
    }
  }

  Future<bool> updateDesignation(
    String id,
    DesignationData updatedDesignation,
  ) async {
    try {
      final success = await _service.updateDesignation(id, updatedDesignation);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedDesignation;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update designation error: $e");
      return false;
    }
  }

  Future<bool> deleteDesignation(String id) async {
    try {
      final success = await _service.deleteDesignation(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete designation error: $e");
      return false;
    }
  }
}
