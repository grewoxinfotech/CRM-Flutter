import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_service.dart';
import '../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../users/controllers/users_controller.dart';

class BranchController extends PaginatedController<BranchData> {
  final BranchService _service = BranchService();
  final String url = UrlRes.branches;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController branchAddressController = TextEditingController();

  final RxList<User> managers = <User>[].obs;
  final UsersController usersController = Get.put(UsersController());
  // EmployeeData? selectedManager;
  Rxn<User> selectedManager = Rxn<User>();

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
    loadManagers();
  }

  void resetForm() {
    branchNameController.clear();
    branchAddressController.clear();
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
