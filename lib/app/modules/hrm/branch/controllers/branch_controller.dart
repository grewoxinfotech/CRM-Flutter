import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_service.dart';

class BranchController extends PaginatedController<BranchData> {
  final BranchService _service = BranchService();
  final String url = UrlRes.branches;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController branchAddressController = TextEditingController();

  // EmployeeData? selectedManager;
  RxString selectedManager = "".obs;

  @override
  Future<List<BranchData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchBranches(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    selectedManager.value = "7dzE4fFaAfNtBUNDxW0xmci";
  }

  void resetForm() {
    branchNameController.clear();
    branchAddressController.clear();
  }

  /// Get single branch by ID
  Future<BranchData?> getBranchById(String id) async {
    try {
      final existingBranch = items.firstWhereOrNull((item) => item.id == id);
      if (existingBranch != null) {
        return existingBranch;
      } else {
        final branch = await _service.getBranchById(id);
        if (branch != null) {
          items.add(branch);
          items.refresh();
          return branch;
        }
      }
    } catch (e) {
      print("Get branch error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createBranch(BranchData branch) async {
    try {
      final success = await _service.createBranch(branch);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create branch error: $e");
      return false;
    }
  }

  Future<bool> updateBranch(String id, BranchData updatedBranch) async {
    try {
      final success = await _service.updateBranch(id, updatedBranch);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedBranch;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update branch error: $e");
      return false;
    }
  }

  Future<bool> deleteBranch(String id) async {
    try {
      final success = await _service.deleteBranch(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete branch error: $e");
      return false;
    }
  }
}
