import 'package:crm_flutter/app/features/screens/home/widget/attendance/widget/graf/features/graf_design.dart';
import 'package:crm_flutter/app/features/screens/home/widget/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(
      AttendanceController(),
    ); // Controller Initialization
    return CrmCard(
      width: 600,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const CrmHeadline(
            title: "Attendance",
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCircularProgress(percentage: 92, width: 140),
              Column(
                children: [
                  CrmButton(
                    title: "Punch In",
                    onTap: () {},
                    width: 110,
                    height: 40,
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.colorScheme.primary,
                        blurRadius: 20,
                        spreadRadius: -10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CrmButton(
                    title: "Punch Out",
                    onTap: () {},
                    width: 110,
                    height: 40,
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.colorScheme.primary,
                        blurRadius: 20,
                        spreadRadius: -10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          TimeRangeSelector(
            onSelected: (selected) {
              controller.selectedRange.value = selected;
              print(
                "Selected Time Range: $selected",
              ); // Selected value print hoga
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
