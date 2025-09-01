import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf_progress.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/controllers/attendence_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../data/network/hrm/hrm_system/attendance/attendance_model.dart';
import '../../../../../data/network/hrm/hrm_system/attendance/attendance_service.dart';

// ====================== Attendance Widget ======================

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentMonth = DateFormat('MMMM').format(currentDate);
    final AttendanceController controller = Get.put(AttendanceController());

    return Obx(() {
      final totalDaysInMonth =
          DateTime(currentDate.year, currentDate.month + 1, 0).day;
      final presentDays =
          controller.attendanceData.map((a) => a.date).toSet().length;

      return CrmCard(
        padding: EdgeInsets.all(AppPadding.small),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          children: [
            CrmHeadline(title: "Attendance of $currentMonth"),
            AppSpacing.verticalLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GrafProgress(
                      percentage:
                      controller.attendancePercentage.value.toDouble(),
                      width: 140,
                    ),
                    AppSpacing.verticalSmall,
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "$presentDays / $totalDaysInMonth days",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CrmButton(
                      title: "Punch In",
                      onTap: controller.isPunchInDisabled.value
                          ? null
                          : () => controller.punchIn(),
                      width: 110,
                      height: 40,
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.colorScheme.primary.withAlpha(75),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMedium,
                    CrmButton(
                      title: "Punch Out",
                      onTap: controller.isPunchOutDisabled.value
                          ? null
                          : () => controller.punchOut(),
                      width: 110,
                      height: 40,
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.colorScheme.primary.withAlpha(75),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.verticalLarge,
            TimeRangeSelector(
              onSelected: (selected) {
                controller.selectedRange.value = selected;
                controller.getAttendanceById(
                  "USER_ID_HERE", // replace with actual user ID
                  range: selected,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

// ====================== Attendance Controller ======================

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = AttendanceService();
  final AttendanceControllerHRM _hrmController = Get.put(
    AttendanceControllerHRM(),
  );

  var isPunchInDisabled = false.obs;
  var isPunchOutDisabled = false.obs;

  var selectedRange = "Month".obs;
  RxList<AttendanceData> attendanceData = <AttendanceData>[].obs;
  var attendancePercentage = 0.obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
    _checkButtonStatus();
  }

  Future<void> _checkButtonStatus() async {
    final now = DateTime.now();
    final storedDate = await SecureStorage.getLastPunchDate();

    if (storedDate != null) {
      final punchDate = DateTime.parse(storedDate);
      if (punchDate.year == now.year &&
          punchDate.month == now.month &&
          punchDate.day == now.day) {
        isPunchInDisabled.value = true;
        isPunchOutDisabled.value = false; // allow punch out
      } else {
        isPunchInDisabled.value = false;
        isPunchOutDisabled.value = true;
      }
    } else {
      isPunchInDisabled.value = false;
      isPunchOutDisabled.value = true;
    }
  }

  Future<void> getUser() async {
    final user = await SecureStorage.getUserData();
    final userId = user?.id ?? "";
    if (userId.isNotEmpty) {
      await getAttendanceById(userId);
    }
  }

  Future<void> getAttendanceById(String userId, {String? range}) async {
    try {
      final now = DateTime.now();
      DateTime start;
      DateTime end;

      switch (range ?? selectedRange.value) {
        case "Day":
          start = DateTime(now.year, now.month, now.day);
          end = start;
          break;
        case "Week":
          start = now.subtract(Duration(days: now.weekday - 1));
          end = start.add(const Duration(days: 6));
          break;
        default:
          start = DateTime(now.year, now.month, 1);
          end = DateTime(now.year, now.month + 1, 0);
      }

      final data = await _hrmController.getAttendanceForEmployee(
        userId,
        start,
        end,
      );

      attendanceData.assignAll(data);
      attendancePercentage.value = _calculatePercentage(start, end);
    } catch (e) {
      print("Error: $e");
    }
  }

  int _calculatePercentage(DateTime start, DateTime end) {
    final totalDays = end.difference(start).inDays + 1;
    final presentDays = attendanceData.map((a) => a.date).toSet().length;
    return ((presentDays / totalDays) * 100).round();
  }

  String formatTimeForBackend(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}:"
        "${dt.second.toString().padLeft(2, '0')}";
  }

  Future<void> punchIn() async {
    try {
      final user = await SecureStorage.getUserData();
      if (user == null || user.id == null) throw "User not found";

      final employeeId = user.id!;
      final now = DateTime.now();
      final data = AttendanceData(
        employee: employeeId,
        date: now.toIso8601String().split('T')[0],
        startTime: formatTimeForBackend(now),
        endTime: null,
      );

      final response = await _attendanceService.createAttendance(data);
      if (response != null) {
        await SecureStorage.saveAttendance(response.id ?? '');
        await SecureStorage.saveLastPunchDate(now);

        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Punched in successfully at ${DateFormat.Hm().format(now)}",
          contentType: ContentType.success,
        );

        isPunchInDisabled.value = true;
        isPunchOutDisabled.value = false;

        await getAttendanceById(employeeId, range: selectedRange.value);
        print("Punch in successful for $employeeId at $now");
        return;
      }

      throw "Failed to punch in: No response from server";
    } catch (e) {
      print("Punch In Error: $e");
    }
  }

  Future<void> punchOut() async {
    try {
      final user = await SecureStorage.getUserData();
      final attendanceId = await SecureStorage.getAttendance();
      print("Attendance ID: $attendanceId");
      final attendance =
      await _attendanceService.getAttendanceById(attendanceId ?? '');
      if (user == null || user.id == null) throw "User not found";

      final employeeId = user.id!;
      final now = DateTime.now();
      final endTime = formatTimeForBackend(now);

      if (attendance == null) throw "No active attendance found";

      final data = AttendanceData(
        id: attendance.id,
        employee: employeeId,
        date: attendance.date,
        startTime: attendance.startTime,
        endTime: endTime,
      );

      final response = await _attendanceService.updateAttendance(
        data.id!,
        data,
      );

      if (!response) {
        throw "Failed to punch out";
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Punched out successfully at ${DateFormat.Hm().format(now)}",
        contentType: ContentType.success,
      );

      isPunchOutDisabled.value = true;

      await getAttendanceById(employeeId, range: selectedRange.value);
      print("Punch out successful for $employeeId at $endTime");
    } catch (e) {
      print("Punch Out Error: $e");
    }
  }
}
