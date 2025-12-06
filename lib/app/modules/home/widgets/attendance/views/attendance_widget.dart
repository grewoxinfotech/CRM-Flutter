

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
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
    final AttendanceController controller = Get.put(AttendanceController());

    return Obx(() {
      final totalDaysInRange =
          controller.rangeEnd.value
              .difference(controller.rangeStart.value)
              .inDays +
          1;

      final presentDays =
          controller.attendanceData.map((a) => a.date).toSet().length;

      final displayRange = controller.selectedRange.value;
      final rangeLabel =
          displayRange == "Month"
              ? DateFormat('MMMM').format(controller.rangeStart.value)
              : displayRange == "Week"
              ? "${DateFormat('dd MMM').format(controller.rangeStart.value)} - ${DateFormat('dd MMM').format(controller.rangeEnd.value)}"
              : DateFormat('dd MMM yyyy').format(controller.rangeStart.value);

      return CrmCard(
        padding: EdgeInsets.all(AppPadding.small),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          children: [
            CrmHeadline(title: "Attendance of $rangeLabel"),
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
                        "$presentDays / $totalDaysInRange days",
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
                      onTap:
                          controller.isPunchInDisabled.value
                              ? null
                              : () => controller.punchIn(),
                      width: 110,
                      height: 40,
                      backgroundColor:
                          controller.isPunchInDisabled.value
                              ? Colors.grey
                              : ColorRes.primary,
                    ),
                    AppSpacing.verticalMedium,
                    CrmButton(
                      title: "Punch Out",
                      onTap:
                          controller.isPunchOutDisabled.value
                              ? null
                              : () => controller.punchOut(),
                      width: 110,
                      height: 40,
                      backgroundColor:
                          controller.isPunchOutDisabled.value
                              ? Colors.grey
                              : ColorRes.primary,
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.verticalLarge,
            TimeRangeSelector(
              onSelected: (selected) async {
                controller.selectedRange.value = selected;
                final user = await SecureStorage.getUserData();
                final userId = user?.id ?? "";
                if (userId.isNotEmpty) {
                  controller.getAttendanceById(userId, range: selected);
                }
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
  final List<String> items = ["Week", "Month"];
  var selectedRange = "Month".obs;
  var rangeStart = DateTime.now().obs;
  var rangeEnd = DateTime.now().obs;

  RxList<AttendanceData> attendanceData = <AttendanceData>[].obs;
  var attendancePercentage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    _checkButtonStatus();
  }

  Future<void> _checkButtonStatus() async {
    try {
      final user = await SecureStorage.getUserData();
      if (user == null || user.id == null) {
        isPunchInDisabled.value = true;
        isPunchOutDisabled.value = true;
        return;
      }

      final employeeId = user.id!;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final records = await _hrmController.getAttendanceForEmployee(
        employeeId,
        today,
        today,
      );

      if (records.isEmpty) {
        isPunchInDisabled.value = false;
        isPunchOutDisabled.value = true;
      } else {
        final todayRecord = records.first;
        if (todayRecord.endTime == null) {
          isPunchInDisabled.value = true;
          isPunchOutDisabled.value = false;
          await SecureStorage.saveAttendance(todayRecord.id ?? '');
        } else {
          isPunchInDisabled.value = true;
          isPunchOutDisabled.value = true;
        }
      }
    } catch (e) {
      isPunchInDisabled.value = true;
      isPunchOutDisabled.value = true;
      print("Check Button Status Error: $e");
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

      // Save for UI
      rangeStart.value = start;
      rangeEnd.value = end;

      final data = await _hrmController.getAttendanceForEmployee(
        userId,
        start,
        end,
      );

      attendanceData.assignAll(data);
      attendancePercentage.value = _calculatePercentage(start, end);
    } catch (e) {
      print("Error fetching attendance: $e");
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
      final today = DateTime(now.year, now.month, now.day);

      final records = await _hrmController.getAttendanceForEmployee(
        employeeId,
        today,
        today,
      );
      if (records.isNotEmpty && records.first.endTime == null) {
        throw "Already punched in today";
      }

      final data = AttendanceData(
        employee: employeeId,
        date: now.toIso8601String().split('T')[0],
        startTime: formatTimeForBackend(now),
        endTime: null,
      );

      final response = await _attendanceService.createAttendance(data);
      if (response == null) throw "Failed to punch in";

      await SecureStorage.saveAttendance(response.id ?? '');

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Punched in at ${DateFormat.Hm().format(now)}",
        contentType: ContentType.success,
      );

      await _checkButtonStatus();
      await getAttendanceById(employeeId, range: selectedRange.value);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: e.toString(),
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> punchOut() async {
    try {
      final user = await SecureStorage.getUserData();
      if (user == null || user.id == null) throw "User not found";

      final employeeId = user.id!;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final records = await _hrmController.getAttendanceForEmployee(
        employeeId,
        today,
        today,
      );
      if (records.isEmpty || records.first.endTime != null) {
        throw "No active attendance found for today";
      }

      final attendance = records.first;
      final updated = AttendanceData(
        id: attendance.id,
        employee: employeeId,
        date: attendance.date,
        startTime: attendance.startTime,
        endTime: formatTimeForBackend(now),
      );

      final response = await _attendanceService.updateAttendance(
        updated.id!,
        updated,
      );
      if (!response) throw "Failed to punch out";

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Punched out at ${DateFormat.Hm().format(now)}",
        contentType: ContentType.success,
      );

      await _checkButtonStatus();
      await getAttendanceById(employeeId, range: selectedRange.value);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: e.toString(),
        contentType: ContentType.failure,
      );
    }
  }
}
