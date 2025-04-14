import 'package:crm_flutter/app/care/constants/size/margin_res.dart';
import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf/features/graf_design.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/time_range_selector.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
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
      padding: PaddingRes.all2,
      margin: MarginRes.horizontal4,
      child: Column(
        children: [
          const CrmHeadline(title: "Attendance"),
          Space(size: 30),
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
                        color: Get.theme.colorScheme.primary.withAlpha(75),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  Space(size: 15),
                  CrmButton(
                    title: "Punch Out",
                    onTap: () {},
                    width: 110,
                    height: 40,
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.colorScheme.primary.withAlpha(75),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Space(size: 30),
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
