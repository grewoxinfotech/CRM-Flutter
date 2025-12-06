import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/hrm/hrm_system/designation/designation_model.dart';
import 'package:crm_flutter/app/modules/hrm/designation/controllers/designation_controller.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/employee/employee_service.dart';

class EmployeeController extends PaginatedController<EmployeeData> {
  final EmployeeService _service = EmployeeService();
  final String url = UrlRes.employees;
  var errorMessage = ''.obs;

  final DesignationController _designationController = Get.put(
    DesignationController(),
  );

  @override
  Future<List<EmployeeData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchEmployees(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Employee";
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

  Future<void> getDesignationById(String id) async {
    try {
      await _designationController.getDesignationById(id);
    } catch (e) {
      print("Get designation error: $e");
    }
  }

  /// Get single employee by ID
  Future<EmployeeData?> getEmployeeById(String id) async {
    try {
      final existingEmployee = items.firstWhereOrNull((item) => item.id == id);
      if (existingEmployee != null) {
        return existingEmployee;
      } else {
        final employee = await _service.getEmployeeById(id);
        if (employee != null) {
          items.add(employee);
          items.refresh();
          return employee;
        }
      }
    } catch (e) {
      print("Get employee error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---

  Future<bool> updateEmployee(String id, EmployeeData updatedEmployee) async {
    try {
      final success = await _service.updateEmployee(id, updatedEmployee);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedEmployee;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update employee error: $e");
      return false;
    }
  }

  Future<bool> deleteEmployee(String id) async {
    try {
      final success = await _service.deleteEmployee(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete employee error: $e");
      return false;
    }
  }
}
