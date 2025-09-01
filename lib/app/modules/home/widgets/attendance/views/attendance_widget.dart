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

// class AttendanceWidget extends StatelessWidget {
//   const AttendanceWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final currentDate = DateTime.now();
//     final currentMonth = DateFormat('MMMM').format(currentDate);
//     final AttendanceController controller = Get.put(
//       AttendanceController(),
//     ); // Controller Initialization
//     return CrmCard(
//       padding: EdgeInsets.all(AppPadding.small),
//       margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
//       child: Column(
//         children: [
//           CrmHeadline(title: "Attendance of $currentMonth"),
//           AppSpacing.verticalLarge,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GrafProgress(percentage: 24, width: 140),
//               Column(
//                 children: [
//                   CrmButton(
//                     title: "Punch In",
//                     onTap: () {},
//                     width: 110,
//                     height: 40,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Get.theme.colorScheme.primary.withAlpha(75),
//                         blurRadius: 10,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   AppSpacing.verticalMedium,
//                   CrmButton(
//                     title: "Punch Out",
//                     onTap: () {},
//                     width: 110,
//                     height: 40,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Get.theme.colorScheme.primary.withAlpha(75),
//                         blurRadius: 10,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           AppSpacing.verticalLarge,
//           TimeRangeSelector(
//             onSelected: (selected) {
//               controller.selectedRange.value = selected;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AttendanceWidget extends StatelessWidget {
//   const AttendanceWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final currentDate = DateTime.now();
//     final currentMonth = DateFormat('MMMM').format(currentDate);
//     final AttendanceController controller = Get.put(AttendanceController());
//
//     // Load attendance for current month initially
//     controller.getAttendanceById("USER_ID_HERE"); // Replace with actual user ID
//
//     return Obx(() {
//       return CrmCard(
//         padding: EdgeInsets.all(AppPadding.small),
//         margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
//         child: Column(
//           children: [
//             CrmHeadline(title: "Attendance of $currentMonth"),
//             AppSpacing.verticalLarge,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 // Dynamic percentage
//                 GrafProgress(
//                   percentage: controller.attendancePercentage.value.toDouble(),
//                   width: 140,
//                 ),
//                 Column(
//                   children: [
//                     CrmButton(
//                       title: "Punch In",
//                       onTap: () => controller.punchIn(),
//                       width: 110,
//                       height: 40,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Get.theme.colorScheme.primary.withAlpha(75),
//                           blurRadius: 10,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     AppSpacing.verticalMedium,
//                     CrmButton(
//                       title: "Punch Out",
//                       onTap: () => controller.punchOut(),
//                       width: 110,
//                       height: 40,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Get.theme.colorScheme.primary.withAlpha(75),
//                           blurRadius: 10,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             AppSpacing.verticalLarge,
//             TimeRangeSelector(
//               onSelected: (selected) {
//                 controller.selectedRange.value = selected;
//                 controller.getAttendanceById(
//                   "USER_ID_HERE", // replace with actual user ID
//                   range: selected,
//                 ); // reload data based on range
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
//
// class AttendanceController extends GetxController {
//   final AttendanceService _attendanceService = AttendanceService();
//   final AttendanceControllerHRM _hrmController = Get.put(
//     AttendanceControllerHRM(),
//   );
//   var selectedRange = "Month".obs;
//   RxList<AttendanceData> attendanceData = <AttendanceData>[].obs;
//   var attendancePercentage = 0.obs;
//
//   Future<void> getAttendanceById(String userId, {String? range}) async {
//     try {
//       final now = DateTime.now();
//       final startOfMonth = DateTime(now.year, now.month, 1);
//       final endOfMonth = DateTime(now.year, now.month + 1, 0);
//       final data = await _hrmController.getAttendanceForEmployee(
//         userId,
//         startOfMonth,
//         endOfMonth,
//       );
//       attendanceData.assignAll(data);
//       attendancePercentage.value = _calculatePercentage(
//         startOfMonth,
//         endOfMonth,
//       );
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   int _calculatePercentage(DateTime start, DateTime end) {
//     final totalDays = end.difference(start).inDays + 1;
//     final presentDays = attendanceData.length; // one entry per day
//     return ((presentDays / totalDays) * 100).round();
//   }
//
//   void punchIn() {
//     // call API
//   }
//
//   void punchOut() {
//     // call API
//   }
// }

import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf_progress.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/controllers/attendence_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ====================== Attendance Widget ======================

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final currentMonth = DateFormat('MMMM').format(currentDate);
    final AttendanceController controller = Get.put(AttendanceController());

    // Load attendance for current month initially
    // controller.getAttendanceById(""); // Replace with actual user ID

    return Obx(() {
      final totalDaysInMonth =
          DateTime(currentDate.year, currentDate.month + 1, 0).day;
      final presentDays = controller.attendanceData.length;

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
                      onTap: () {
                        controller.punchIn();
                      },
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
                      onTap: () => controller.punchOut(),
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

  var selectedRange = "Month".obs;
  RxList<AttendanceData> attendanceData = <AttendanceData>[].obs;
  var attendancePercentage = 0.obs;

  @override
  onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    final user = await SecureStorage.getUserData();
    final userId = user?.id ?? "";
    getAttendanceById(userId);
  }

  Future<void> getAttendanceById(String userId, {String? range}) async {
    try {
      final now = DateTime.now();

      DateTime start;
      DateTime end;

      // Determine date range based on selected range
      switch (range ?? selectedRange.value) {
        case "Day":
          start = DateTime(now.year, now.month, now.day);
          end = start;
          break;
        case "Week":
          start = now.subtract(Duration(days: now.weekday - 1)); // Monday
          end = start.add(const Duration(days: 6));
          break;
        default: // Month
          start = DateTime(now.year, now.month, 1);
          end = DateTime(now.year, now.month + 1, 0);
      }

      final data = await _hrmController.getAttendanceForEmployee(
        userId,
        start,
        end,
      );
      print("Attendance Data: $data");

      attendanceData.assignAll(data);
      attendancePercentage.value = _calculatePercentage(start, end);
    } catch (e) {
      print("Error: $e");
    }
  }

  int _calculatePercentage(DateTime start, DateTime end) {
    final totalDays = end.difference(start).inDays + 1;
    final presentDays = attendanceData.length; // one entry per day
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
      if (user == null) throw "User not found";

      final employeeId = user.id;
      if (employeeId == null) throw "Employee ID not found";

      final now = DateTime.now();
      final data = AttendanceData(
        employee: employeeId,
        date: now.toIso8601String().split('T')[0], // e.g., "2025-09-01"
        startTime: formatTimeForBackend(now), // full timestamp
        endTime: null, // empty initially
      );

      // Example: send to backend
      final response = await _attendanceService.createAttendance(data);
      if (!response) {
        throw "Failed to punch in: ${response.toString()}";
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Punched in successfully at ${DateFormat.Hm().format(now)}",
        contentType: ContentType.success,
      );
      await getAttendanceById(employeeId, range: selectedRange.value);

      print("Punch in successful for $employeeId at $now");
    } catch (e) {
      print("Punch In Error: $e");
    }
  }

  Future<void> punchOut() async {
    try {
      final user = await SecureStorage.getUserData();
      if (user == null) throw "User not found";

      final employeeId = user.id;
      if (employeeId == null) throw "Employee ID not found";

      final now = DateTime.now();
      final endTime = formatTimeForBackend(now);

      final data = AttendanceData(
        employee: employeeId,
        date: now.toIso8601String().split('T')[0],
        endTime: endTime, // empty initially
      );

      // Update today's attendance with endTime
      final response = await _attendanceService.updateAttendance(
        employeeId,
        data,
      );

      if (!response) {
        throw "Failed to punch out: ${response.toString()}";
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Punched out successfully at ${DateFormat.Hm().format(now)}",
        contentType: ContentType.success,
      );

      // Refresh attendance list
      await getAttendanceById(employeeId, range: selectedRange.value);

      print("Punch out successful for $employeeId at $endTime");
    } catch (e) {
      print("Punch Out Error: $e");
    }
  }
}
