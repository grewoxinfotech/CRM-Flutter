import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../../../data/network/hrm/hrm_system/departments/department_model.dart';
import '../../../../data/network/hrm/hrm_system/departments/department_service.dart';

class DepartmentController extends PaginatedController<DepartmentData> {
  final DepartmentService _service = DepartmentService();
  final String url = UrlRes.departments;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController departmentNameController =
      TextEditingController();

  // --- BRANCHES ---
  final RxList<BranchData> branches = <BranchData>[].obs;
  final BranchController branchController = Get.put(BranchController());
  RxnString selectedBranch = RxnString();

  @override
  Future<List<DepartmentData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchDepartments(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Department";
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
    departmentNameController.clear();
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

  /// Get single department by ID
  Future<DepartmentData?> getDepartmentById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final department = await _service.getDepartmentById(id);
        if (department != null) {
          items.add(department);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get department error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createDepartment(DepartmentData department) async {
    try {
      final success = await _service.createDepartment(department);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create department error: $e");
      return false;
    }
  }

  Future<bool> updateDepartment(
    String id,
    DepartmentData updatedDepartment,
  ) async {
    try {
      final success = await _service.updateDepartment(id, updatedDepartment);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedDepartment;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update department error: $e");
      return false;
    }
  }

  Future<bool> deleteDepartment(String id) async {
    try {
      final success = await _service.deleteDepartment(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete department error: $e");
      return false;
    }
  }
}
