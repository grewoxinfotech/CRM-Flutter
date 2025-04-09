import 'package:crm_flutter/app/features/presentation/screens/home/widget/attendance/widget/graf/features/graf_design.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/widget/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController()); // Controller Initialization
    return CrmContainer(
      width: 600,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
              CustomCircularProgress(percentage: 92, width: 150),
              Column(
                children: [
                  CrmButton(title: "Punch In", onPressed: () {},width: 100,height: 30,),
                  CrmButton(title: "Punch Out", onPressed: () {},width: 100,height: 30,),
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
