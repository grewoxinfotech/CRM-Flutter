import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/hrm_system/attendance/attendance_model.dart';
import '../../employee/controllers/employee_controller.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceData attendance;

  AttendanceCard({super.key, required this.attendance}) {
    _loadEmployeeData();
  }

  final employeeData = Rxn<EmployeeData>();

  void _loadEmployeeData() async {
    Get.lazyPut(() => EmployeeController());
    final employeeController = Get.find<EmployeeController>();
    final data = await employeeController.getEmployeeById(attendance.employee!);
    employeeData.value = data;
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              children: [
                // Icon Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.orange[100],
                    child: Icon(Icons.event, color: Colors.orange[700], size: 32),
                  ),
                ),
                const SizedBox(width: 12),

                // Attendance Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Employee Name (Reactive)
                      Obx(
                        () => Text(
                          employeeData.value?.firstName ?? "Loading...",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Date Range
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
