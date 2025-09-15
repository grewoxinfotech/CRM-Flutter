import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/hrm/leave/leave/leave_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/hrm_system/leave_type/leave_service.dart';
import '../../../../data/network/hrm/hrm_system/leave_type/leave_types_model.dart';
import '../../employee/controllers/employee_controller.dart';

class LeaveController extends PaginatedController<LeaveData> {
  final LeaveService _service = LeaveService();
  final String url = UrlRes.leaves;
  var errorMessage = ''.obs;

  /// Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Reactive form fields
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  Rxn<DateTime> selectedStartDate = Rxn<DateTime>();
  Rxn<DateTime> selectedEndDate = Rxn<DateTime>();
  List<String> leaveTypes = ["annual", "sick", "casual", "other"];
  final RxnString selectedLeaveType = RxnString(); // e.g., sick, casual, annual
  final RxBool isHalfDay = false.obs;
  // final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  // final Rx<DateTime?> endDate = Rx<DateTime?>(null);

  // --- EMPLOYEE ---
  final RxList<EmployeeData> employees = <EmployeeData>[].obs;
  final EmployeeController employeeController = Get.put(EmployeeController());
  var selectedEmployee = Rxn<EmployeeData>();

  @override
  Future<List<LeaveData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchLeaves(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Leave";
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
    _loadEmployees();
  }

  void _loadEmployees() async {
    try {
      await employeeController.loadInitial(); // fetches branches
      employees.assignAll(employeeController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  Future<void> getEmployeeById(String id) async {
    try {
      final employee = await employeeController.getEmployeeById(id);
      if (employee != null) {
        selectedEmployee.value = employee;
      }
    } catch (e) {
      print("Get employee error: $e");
    }
  }

  void resetForm() {
    reasonController.clear();
    selectedLeaveType.value = null;
    selectedStartDate.value = null;
    selectedEndDate.value = null;
    startDateController.clear();
    endDateController.clear();
    isHalfDay.value = false;
    selectedEmployee.value = null;
    if (employeeController.items.isNotEmpty && selectedEmployee.value == null) {
      selectedEmployee.value = employeeController.items.first;
      selectedLeaveType.value = leaveTypes.first;
    }
  }

  /// Get single leave by ID
  Future<LeaveData?> getLeaveById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final leave = await _service.getLeaveById(id);
        if (leave != null) {
          items.add(leave);
          items.refresh();
        }
        return leave;
      }
    } catch (e) {
      print("Get leave error: $e");
      return null;
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createLeave(LeaveData leave) async {
    try {
      final success = await _service.createLeave(leave);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create leave error: $e");
      return false;
    }
  }

  Future<bool> approveLeave(LeaveData leave) async {
    try {
      final success = await _service.approveLeave(leave);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create leave error: $e");
      return false;
    }
  }

  Future<bool> updateLeave(String id, LeaveData updatedLeave) async {
    try {
      final success = await _service.updateLeave(id, updatedLeave);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedLeave;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update leave error: $e");
      return false;
    }
  }

  Future<bool> deleteLeave(String id) async {
    try {
      final success = await _service.deleteLeave(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete leave error: $e");
      return false;
    }
  }

  /// Approve/Reject Leave (extra helper)
  Future<bool> updateLeaveStatus(String id, String status) async {
    try {
      final leave = await getLeaveById(id);
      if (leave != null) {
        leave.status = status;
        final success = await _service.updateLeave(id, leave);
        if (success) {
          int index = items.indexWhere((item) => item.id == id);
          if (index != -1) {
            items[index] = leave;
            items.refresh();
          }
        }
        return success;
      }
    } catch (e) {
      print("Update leave status error: $e");
    }
    return false;
  }
}
