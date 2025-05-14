import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/controllers/attendance_controller.dart';
import 'package:crm_flutter/app/modules/hrm/leave/controllers/leave_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/crm_indicator.dart';
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
      height: AppPadding.large,
      endIndent: AppPadding.medium,
      indent: AppPadding.medium,
    );

    Widget _buildAttendanceCell(DateTime day, {bool isToday = false,bool isSelected = false}) {
      final status =
          attendanceController.attendanceMap[DateTime(
            day.year,
            day.month,
            day.day,
          )];
      Color bgColor = Colors.transparent;
      IconData? icon;
      if (status == 'present') {
        bgColor = success.withAlpha(100);
        icon = FontAwesomeIcons.check;
      } else if (status == 'absent') {
        bgColor = error.withAlpha(100);
        icon = FontAwesomeIcons.cancel;
      } else if (status == 'model') {
        bgColor = warning.withAlpha(100);
        icon = Icons.leave_bags_at_home_rounded;
      } else {}
      if (isToday) bgColor = Get.theme.colorScheme.onPrimary.withAlpha(50);
      if (isSelected) bgColor = Get.theme.colorScheme.primary.withAlpha(50);
      return Center(
        child: CircleAvatar(
          backgroundColor: bgColor,
          radius: AppPadding.medium,
          child:
              (icon != null)
                  ? Icon(icon, size: AppPadding.medium)
                  : Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: AppPadding.medium,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.colorScheme.onPrimary,
                    ),
                  ),
        ),
      );
    }

    final List<LeaveColorModel> leaveColors = LeaveColorModel.getLeaves();

    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Attendance")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.medium),
        child: Column(
          children: [
            CrmCard(
              padding: EdgeInsets.all(AppPadding.small),
              child: Column(
                children: [
                  Obx(
                    () => TableCalendar(
                      rowHeight: 40,
                      daysOfWeekHeight: 30,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        headerPadding: EdgeInsets.zero,
                        headerMargin: EdgeInsets.zero,
                        formatButtonVisible: false,
                        formatButtonShowsNext: false,
                        titleTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.colorScheme.onSecondary,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.colorScheme.onSecondary,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),

                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2030),

                      focusedDay: attendanceController.focusedDay.value,
                      selectedDayPredicate:
                          (day) => attendanceController.isSameDay(
                            attendanceController.selectedDay.value,
                            day,
                          ),
                      onDaySelected:
                          (selected, focused) => attendanceController
                              .onDaySelected(selected, focused),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder:
                            (context, day, focusedDay) =>
                                _buildAttendanceCell(day),
                        todayBuilder:
                            (context, day, focusedDay) =>
                                _buildAttendanceCell(day, isToday: true),
                        selectedBuilder:
                            (context, day, focusedDay) =>
                                _buildAttendanceCell(day, isSelected: true),
                      ),
                    ),
                  ),
                  divider,
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
                        attendanceController.attendanceMap[dayKey] = 'model';
                        attendanceController.focusedDay.value = picked;
                        attendanceController.selectedDay.value = picked;
                        attendanceController.update(); // Just in case
                      }
                    },
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSmall,
            CrmCard(
              padding: EdgeInsets.all(AppPadding.small),
              child: ViewScreen(
                itemCount: leaveColors.length,
                padding: EdgeInsets.all(AppPadding.small),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, i) => CrmIndicator(
                      color: leaveColors[i].color.withAlpha(100),
                      text: leaveColors[i].leaveType,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
