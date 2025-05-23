import 'package:crm_flutter/app/data/network/all/hrm/attendance/model/attendance_model.dart';
import 'package:crm_flutter/app/data/network/all/hrm/attendance/service/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceController extends GetxController {
  final List<AttendanceModel> attendance = <AttendanceModel>[].obs;
  final attendanceService = AttendanceService();
  final isLoading = false.obs;
  final focusedDay = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>();
  final selectedDates = <DateTime>[].obs;
  var calendarFormat = CalendarFormat.week.obs;


  var isPunchedIn = false.obs;
  var punchTime = ''.obs;
  void togglePunch() {
    isPunchedIn.value = !isPunchedIn.value;
    punchTime.value = DateFormat('hh:mm a').format(DateTime.now());
  }

  final Map<DateTime, String> attendanceMap = {
    DateTime(2025, 5, 1): 'present',
    DateTime(2025, 5, 2): 'absent',
    DateTime(2025, 5, 3): 'present',
    DateTime(2025, 5, 4): 'model',
  };

  @override
  void onInit() {
    super.onInit();
    fetchAttendances();
  }

  void askForLeave() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      DateTime dayKey = DateTime(picked.year, picked.month, picked.day);
      attendanceMap[dayKey] = 'model';
      focusedDay.value = picked;
      selectedDay.value = picked;
      update(); // Just in case
    }
  }

  Future<List> fetchAttendances() async {
    isLoading.value = true;
    try {
      final data = await attendanceService.getAllAttendances();
      print("Attendance Controller (data) : $data");
      attendance.assignAll(
        data.map((e) => AttendanceModel.fromJson(e)).toList(),
      );
      print("Attendance Controller (attendance) : ${attendance.toString()}");
      // syncCalendarMap();
      return data ?? [];
    } catch (e) {
      print("Attendance Controller (error) : $e");
      return [];
    }
  }

  // void syncCalendarMap() {
  //   attendanceMap.clear();
  //   for (var entry in attendance) {
  //     final key = DateTime(entry.date.year, entry.date.month, entry.date.day);
  //     attendanceMap[key] = entry.endTime.isEmpty ? 'absent' : 'present';
  //   }
  // }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> punchIn(String empId) async {
    final success = await AttendanceService().punchIn(empId);
    if (success) fetchAttendances();
  }

  Future<void> punchOut(String attendanceId) async {
    final success = await AttendanceService().punchOut(attendanceId);
    if (success) fetchAttendances();
  }
}
