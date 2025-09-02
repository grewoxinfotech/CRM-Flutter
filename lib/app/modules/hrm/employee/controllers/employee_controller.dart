import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/employee/employee_service.dart';

class EmployeeController extends PaginatedController<EmployeeData> {
  final EmployeeService _service = EmployeeService();
  final String url = UrlRes.employees;
  var error = ''.obs;

  @override
  Future<List<EmployeeData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchEmployees(page: page);

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
  // Future<bool> createEmployee(EmployeeData employee) async {
  //   try {
  //     final success = await _service.createEmployee(employee);
  //     if (success) {
  //       await loadInitial();
  //     }
  //     return success;
  //   } catch (e) {
  //     print("Create employee error: $e");
  //     return false;
  //   }
  // }

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
