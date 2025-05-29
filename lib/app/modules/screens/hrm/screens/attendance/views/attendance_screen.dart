import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/controllers/attendance_controller.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/controllers/leave_controller.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/widgets/leave_list.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/crm_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController attendanceController = Get.put(
      AttendanceController(),
    );
    final LeaveController leaveController = Get.put(LeaveController());

    final List<LeaveColorModel> leaveColors = LeaveColorModel.getLeaves();

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
      if (status == 'present') {
        bgColor = AppColors.success.withAlpha(100);
      } else if (status == 'absent') {
        bgColor = AppColors.error.withAlpha(100);
        icon = LucideIcons.clock;
      } else if (status == 'model') {
        bgColor = AppColors.warning.withAlpha(100);
        icon = LucideIcons.home;
      } else {}
      if (isToday) bgColor = Get.theme.colorScheme.onPrimary.withAlpha(50);
      if (isSelected) bgColor = Get.theme.colorScheme.primary.withAlpha(50);
      return Center(
        child: CircleAvatar(
          backgroundColor: bgColor,
          radius: AppPadding.medium,
          child:
              (icon != null)
                  ? CrmIc(icon: icon,size: AppPadding.medium)
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

    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        title: Text("Attendance"),
        actions: [
          CrmButton(
            width: 80,
            height: 30,
            boxShadow: [],
            title: "Export",
            onTap: () => print("Export File"),
          ),
          PopupMenuButton<String>(
            icon: CrmIc(icon: LucideIcons.info),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.large),
              side: BorderSide(color: AppColors.divider),
            ),
            elevation: 5,
            useRootNavigator: true,
            shadowColor: AppColors.white,
            padding: EdgeInsets.all(0),
            onSelected: (value) {
              // Use selected value
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Selected: $value')));
            },
            itemBuilder: (BuildContext context) {
              return leaveColors.map((item) {
                return PopupMenuItem<String>(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.small,
                    vertical: AppPadding.small / 2,
                  ),
                  enabled: false,
                  value: item.leaveType,
                  height: AppPadding.small,
                  child: CrmIndicator(
                    color: item.color.withAlpha(100),
                    text: item.leaveType,
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => leaveController.addLeave(),
        icon: Icon(Icons.add_task, color: Colors.white),
        label: Text(
          "Ask for Leave",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.medium),
        child: Column(
          children: [
            // calender
            CrmCard(
              boxShadow: [],
              border: Border.all(color: AppColors.divider),
              padding: EdgeInsets.all(AppPadding.small),
              child: Obx(
                () => TableCalendar(
                  rowHeight: 40,
                  daysOfWeekHeight: 30,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'week',
                  },

                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    headerPadding: EdgeInsets.zero,
                    headerMargin: EdgeInsets.zero,
                    formatButtonVisible: true,
                    formatButtonShowsNext: true,
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
                      (selected, focused) =>
                          attendanceController.onDaySelected(selected, focused),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder:
                        (context, day, focusedDay) => _buildAttendanceCell(day),
                    todayBuilder:
                        (context, day, focusedDay) =>
                            _buildAttendanceCell(day, isToday: true),
                    selectedBuilder:
                        (context, day, focusedDay) =>
                            _buildAttendanceCell(day, isSelected: true),
                  ),
                ),
              ),
            ),
            AppSpacing.verticalMedium,

            CrmHeadline(title: "Leaves"),
            LeaveList(
              padding: EdgeInsets.symmetric(vertical: AppPadding.small),
            ),
          ],
        ),
      ),
    );
  }
}
