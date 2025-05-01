import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf_progress.dart';
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
      shadowColor: Get.theme.colorScheme.surface,
      padding: EdgeInsets.all(AppPadding.small),
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        children: [
          const CrmHeadline(title: "Attendance"),
          AppSpacing.verticalLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GrafProgress(percentage: 24, width: 140),
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
                  AppSpacing.verticalMedium,
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
          AppSpacing.verticalLarge,
          TimeRangeSelector(
            onSelected: (selected) {
              controller.selectedRange.value = selected;
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
