import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/attendance_button.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/graf/graf.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: 500,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const CrmHeadline(title: "Attendance", showViewAll: false),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCircularProgress(percentage: 22),
              Column(
                children: [
                  AttendanceButton(title: "Punch In",onPressed: (){}),
                  const SizedBox(height: 5),
                  AttendanceButton(title: "Punch Out",onPressed: (){}),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          TimeRangeSelector(),
        ],
      ),
    );
  }
}
