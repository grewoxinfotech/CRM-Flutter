import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/modules/hrm/employee/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/hrm_system/attendance/attendance_model.dart';
import '../../../../data/network/hrm/hrm_system/attendance/attendance_service.dart';

class AttendanceControllerHRM extends PaginatedController<AttendanceData> {
  final AttendanceService _service = AttendanceService();
  final String url = UrlRes.attendance;
  var error = ''.obs;
  RxString selectedRange = "Month".obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController holidayNameController = TextEditingController();
  final TextEditingController leaveTypeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  RxString selectedLeaveType = "paid".obs; // Default selection

  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Future<List<AttendanceData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchAttendance(page: page);

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

  void resetForm() {
    holidayNameController.clear();
    leaveTypeController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedLeaveType.value = "paid";
  }

  /// Get single attendance record by ID
  Future<AttendanceData?> getAttendanceById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final attendance = await _service.getAttendanceById(id);
        if (attendance != null) {
          items.add(attendance);
          items.refresh();
          return attendance;
        }
      }
    } catch (e) {
      print("Get attendance error: $e");
    }
    return null;
  }

  Future<EmployeeData> getEmployeeById(String id) async {
    final employee = await employeeController.getEmployeeById(id);
    return employee!;
  }

  Future<List<AttendanceData>> getAttendanceForEmployee(
    String employeeId,
    DateTime start,
    DateTime end,
  ) async {
    try {
      await loadInitial();

      // Filter from items already loaded
      return items.where((a) {
        final attDate = DateTime.tryParse(
          a.date ?? "",
        ); // adjust field if different
        if (attDate == null) return false;

        return a.employee == employeeId &&
            attDate.isAfter(start.subtract(const Duration(days: 1))) &&
            attDate.isBefore(end.add(const Duration(days: 1)));
      }).toList();
    } catch (e) {
      print("Error filtering attendance: $e");
      return [];
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createAttendance(AttendanceData attendance) async {
    try {
      final success = await _service.createAttendance(attendance);
      if (success != null) {
        await loadInitial();
        return true;
      }
      return false;
    } catch (e) {
      print("Create attendance error: $e");
      return false;
    }
  }

  Future<bool> updateAttendance(
    String id,
    AttendanceData updatedAttendance,
  ) async {
    try {
      final success = await _service.updateAttendance(id, updatedAttendance);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedAttendance;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update attendance error: $e");
      return false;
    }
  }

  Future<bool> deleteAttendance(String id) async {
    try {
      final success = await _service.deleteAttendance(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete attendance error: $e");
      return false;
    }
  }
}
