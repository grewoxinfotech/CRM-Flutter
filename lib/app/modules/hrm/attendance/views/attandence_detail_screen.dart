import 'package:crm_flutter/app/modules/hrm/attendance/controllers/attendence_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/hrm_system/attendance/attendance_model.dart';

class AttendanceDetailController extends GetxController {
  final List<AttendanceData> allAttendance;

  AttendanceDetailController(this.allAttendance);

  var selectedMonth = DateTime.now().month.obs;
  var selectedYear = DateTime.now().year.obs;

  void changeMonth(int month, int year) {
    selectedMonth.value = month;
    selectedYear.value = year;
  }

  bool isPresent(DateTime date) {
    return allAttendance.any((a) {
      final attDate = DateTime.tryParse(a.date! ?? '');
      return attDate != null &&
          attDate.year == date.year &&
          attDate.month == date.month &&
          attDate.day == date.day;
    });
  }
}

class AttendanceDetailScreen extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  AttendanceDetailScreen({super.key, required this.attendanceData});

  late final AttendanceDetailController controller = Get.put(
    AttendanceDetailController(attendanceData),
  );

  final List<String> monthNames = List.generate(
    12,
    (i) => DateFormat.MMMM().format(DateTime(0, i + 1)),
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AttendanceControllerHRM());
    final AttendanceControllerHRM attendanceController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Detail")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Month & Year Dropdown
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: controller.selectedMonth.value,
                      items: List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text(monthNames[index]),
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          controller.changeMonth(
                            value,
                            controller.selectedYear.value,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: controller.selectedYear.value,
                      items: List.generate(5, (index) {
                        final year = DateTime.now().year - 2 + index;
                        return DropdownMenuItem(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          controller.changeMonth(
                            controller.selectedMonth.value,
                            value,
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }),

            // CrmButton(
            //   width: double.infinity,
            //   title: 'Get',
            //   onTap: () async {
            //     final DateTime now = DateTime.now();
            //     final DateTime startOfMonth = DateTime(now.year, now.month, 1);
            //     final DateTime endOfMonth = DateTime(
            //       now.year,
            //       now.month + 1,
            //       0,
            //     ); // last day of m
            //
            //     final data = await attendanceController
            //         .getAttendanceForEmployee(
            //           attendanceData.map((e) => e.employee).toList().id ?? "",
            //           startOfMonth,
            //           endOfMonth,
            //         );
            //     Get.back();
            //     Get.to(
            //       () => AttendanceDetailScreen(attendanceData: attendanceData),
            //     );
            //   },
            // ),
            const SizedBox(height: 16),

            // Attendance List
            Expanded(
              child: Obx(() {
                final daysInMonth = DateUtils.getDaysInMonth(
                  controller.selectedYear.value,
                  controller.selectedMonth.value,
                );

                final days = List.generate(
                  daysInMonth,
                  (i) => DateTime(
                    controller.selectedYear.value,
                    controller.selectedMonth.value,
                    i + 1,
                  ),
                );

                return ListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final present = controller.isPresent(day);
                    final isToday = DateUtils.isSameDay(day, DateTime.now());

                    return Card(
                      color: isToday ? Colors.blue[50] : null,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: present ? Colors.green : Colors.red,
                          child: Icon(
                            present ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          DateFormat('dd MMM yyyy (EEEE)').format(day),
                        ),
                        subtitle: Text(present ? "Present" : "Absent"),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
