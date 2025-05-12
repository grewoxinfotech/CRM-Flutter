import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/controllers/attendance_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController attendanceController = Get.put(
      AttendanceController(),
    );


    Widget divider = Divider(
      color: Get.theme.dividerColor,
      height: AppPadding.medium * 2,
    );

    Widget _buildAttendanceCell(
      DateTime day, {
      bool isToday = false,
      bool isSelected = false,
    }) {
      final status =
          attendanceController.attendanceMap[DateTime(
            day.year,
            day.month,
            day.day,
          )];
      Color bgColor = Colors.transparent;
      IconData? icon;

      switch (status) {
        case 'present':
          bgColor = Colors.green.shade200;
          icon = FontAwesomeIcons.arrowUp;
          break;
        case 'absent':
          bgColor = Colors.red.shade200;
          icon = FontAwesomeIcons.arrowUp;
          break;
        case 'leave':
          bgColor = Colors.orange.shade200;
          icon = Icons.leave_bags_at_home_rounded;
          break;
      }

      if (isToday) bgColor = Colors.blue.shade100;
      if (isSelected) bgColor = Colors.deepPurple.shade100;

      return CircleAvatar(
        backgroundColor: bgColor,
        radius: AppPadding.medium,
        child:
            (icon != null)
                ? Icon(icon, size: AppPadding.medium)
                : Stack(
                  alignment: Alignment.center,
                  children: [
                    Text('${day.day}',style: TextStyle(
                      fontSize: AppPadding.medium,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.colorScheme.onPrimary,
                    ),),
                    if (icon != null)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(icon, size: 14),
                      ),
                  ],
                ),
      );
    }

    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Attendance")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.medium),
        child: Column(
          children: [
            CrmCard(
              padding: EdgeInsets.all(AppPadding.medium),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://i.pinimg.com/736x/ce/f4/1e/cef41e3983b49cb5fde2a299dfe6d2dd.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: AppPadding.medium,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                        children: [
                          TextSpan(text: "Attendance\t"),
                          TextSpan(
                            text:
                                "${attendanceController.attendanceMap.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: AppPadding.medium * 2,
                            ),
                          ),
                          TextSpan(text: "\tday"),
                        ],
                      ),
                    ),
                  ),
                  divider,

                  /// ✅ Obx wrapped for reactive calendar
                  Obx(
                    () => TableCalendar(
                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2030),
                      focusedDay: attendanceController.focusedDay.value,
                      selectedDayPredicate:
                          (day) => attendanceController.isSameDay(
                            attendanceController.selectedDay.value,
                            day,
                          ),
                      calendarFormat: CalendarFormat.month,
                      onDaySelected:
                          (selected, focused) => attendanceController
                              .onDaySelected(selected, focused),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          return _buildAttendanceCell(day);
                        },
                        todayBuilder: (context, day, focusedDay) {
                          return _buildAttendanceCell(day, isToday: true);
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          return _buildAttendanceCell(day, isSelected: true);
                        },
                      ),
                    ),
                  ),
                  divider,

                  /// ✅ Ask for Leave button
                  CrmButton(
                    width: double.infinity,
                    title: "Ask for Leave",
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                      );

                      if (picked != null) {
                        DateTime dayKey = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                        );
                        attendanceController.attendanceMap[dayKey] = 'leave';
                        attendanceController.focusedDay.value = picked;
                        attendanceController.selectedDay.value = picked;
                        attendanceController.update(); // Just in case
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
