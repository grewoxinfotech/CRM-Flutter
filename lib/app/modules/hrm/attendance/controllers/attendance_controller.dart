import 'package:crm_flutter/app/data/network/hrm/attendance/model/attendance_model.dart';
import 'package:crm_flutter/app/data/network/hrm/attendance/service/attendance_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/service/user_service.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final attendanceList = <AttendanceModel>[].obs;
  final attendanceService = AttendanceService();
  final isLoading = false.obs;
  final focusedDay = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>();
  final userService = UserService();

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
    getUserId();
  }

  String getUserId() {
    final user = userService.user.value!;
    print(user.id);
    return user.id.toString();
  }

  void fetchAttendances() async {
    isLoading.value = true;
    try {
      final result = await attendanceService.getAllAttendances();
      attendanceList.assignAll(result);
      syncCalendarMap();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void syncCalendarMap() {
    attendanceMap.clear();
    for (var entry in attendanceList) {
      final key = DateTime(entry.date.year, entry.date.month, entry.date.day);
      attendanceMap[key] = entry.endTime.isEmpty ? 'absent' : 'present';
    }
  }

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
