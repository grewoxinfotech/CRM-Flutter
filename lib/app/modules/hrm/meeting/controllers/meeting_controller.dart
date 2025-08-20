import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:crm_flutter/app/data/network/hrm/hrm_system/departments/department_model.dart';
import 'package:crm_flutter/app/modules/hrm/department/controllers/department_controller.dart';
import 'package:crm_flutter/app/modules/hrm/employee/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/meeting/meeting_model.dart';
import '../../../../data/network/hrm/meeting/meeting_service.dart';

class MeetingController extends PaginatedController<MeetingData> {
  final MeetingService _service = MeetingService();
  final String url = UrlRes.meetings;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController meetingLinkController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  RxString selectedDepartment = "".obs;
  RxList<String> selectedEmployees = <String>[].obs;
  RxString selectedClientId = "".obs;

  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedStartTime = Rxn<TimeOfDay>();
  Rxn<TimeOfDay> selectedEndTime = Rxn<TimeOfDay>();

  // --- DEPARTMENT ---
  final RxList<DepartmentData> departments = <DepartmentData>[].obs;
  final DepartmentController departmentController = Get.put(
    DepartmentController(),
  );

  // --- EMPLOYEE ---
  final RxList<EmployeeData> employees = <EmployeeData>[].obs;
  final EmployeeController employeeController = Get.put(EmployeeController());
  RxString status = "scheduled".obs;

  @override
  Future<List<MeetingData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchMeetings(page: page);
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
    _loadDepartments();
    _loadEmployees();
    status.value = "scheduled";
  }

  void _loadDepartments() async {
    try {
      await departmentController.loadInitial(); // fetches branches
      departments.assignAll(departmentController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  void _loadEmployees() async {
    try {
      await employeeController.loadInitial(); // fetches branches
      employees.assignAll(employeeController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    meetingLinkController.clear();
    startTimeController.clear();
    endTimeController.clear();
    selectedDepartment.value = "";
    selectedEmployees.clear();
    selectedClientId.value = "";
    selectedDate.value = null;
    selectedStartTime.value = null;
    selectedEndTime.value = null;
    status.value = "scheduled";
  }

  /// Get single meeting by ID
  Future<MeetingData?> getMeetingById(String id) async {
    try {
      final existingMeeting = items.firstWhereOrNull((item) => item.id == id);
      if (existingMeeting != null) {
        return existingMeeting;
      } else {
        final meeting = await _service.getMeetingById(id);
        if (meeting != null) {
          items.add(meeting);
          items.refresh();
          return meeting;
        }
      }
    } catch (e) {
      print("Get meeting error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createMeeting(MeetingData meeting) async {
    try {
      final success = await _service.createMeeting(meeting);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create meeting error: $e");
      return false;
    }
  }

  Future<bool> updateMeeting(String id, MeetingData updatedMeeting) async {
    try {
      final success = await _service.updateMeeting(id, updatedMeeting);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedMeeting;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update meeting error: $e");
      return false;
    }
  }

  Future<bool> deleteMeeting(String id) async {
    try {
      final success = await _service.deleteMeeting(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete meeting error: $e");
      return false;
    }
  }
}
