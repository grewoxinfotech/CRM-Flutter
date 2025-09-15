import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/hrm_system/holiday/holiday_model.dart';
import '../../../../data/network/hrm/hrm_system/holiday/holiday_service.dart';

class HolidayController extends PaginatedController<HolidayData> {
  final HolidayService _service = HolidayService();
  final String url = UrlRes.holidays;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController holidayNameController = TextEditingController();
  final TextEditingController leaveTypeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Rxn<DateTime> selectedStartDate = Rxn<DateTime>();
  Rxn<DateTime> selectedEndDate = Rxn<DateTime>();

  List<String> leaveTypes = ["paid", "unpaid"];
  RxnString selectedLeaveType = RxnString();

  @override
  Future<List<HolidayData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchHolidays(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Holiday";
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
    holidayNameController.clear();
    leaveTypeController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStartDate.value = null;
    selectedEndDate.value = null;
    selectedLeaveType.value = leaveTypes.first;
  }

  /// Get single holiday by ID
  Future<HolidayData?> getHolidayById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final holiday = await _service.getHolidayById(id);
        if (holiday != null) {
          items.add(holiday);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get holiday error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createHoliday(HolidayData holiday) async {
    try {
      final success = await _service.createHoliday(holiday);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create holiday error: $e");
      return false;
    }
  }

  Future<bool> updateHoliday(String id, HolidayData updatedHoliday) async {
    try {
      final success = await _service.updateHoliday(id, updatedHoliday);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedHoliday;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update holiday error: $e");
      return false;
    }
  }

  Future<bool> deleteHoliday(String id) async {
    try {
      final success = await _service.deleteHoliday(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete holiday error: $e");
      return false;
    }
  }
}
