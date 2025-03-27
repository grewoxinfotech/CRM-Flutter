import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/attendance_button.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/graf/graf_design.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController()); // Controller Initialization
    return CrmContainer(
      width: 500,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CrmHeadline(title: "Attendance", showViewAll: false),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCircularProgress(percentage: 20,width: 150,),
              Column(
                children: [
                  AttendanceButton(title: "Punch In", onPressed: () {}),
                  const SizedBox(height: 5),
                  AttendanceButton(title: "Punch Out", onPressed: () {}),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          TimeRangeSelector(
            onSelected: (selected) {
              controller.selectedRange.value = selected;
              print("Selected Time Range: $selected"); // Selected value print hoga
            },
          ),
        ],
      ),
    );
  }
}
class AttendanceController extends GetxController {
  RxString selectedRange = "Week".obs;
}
