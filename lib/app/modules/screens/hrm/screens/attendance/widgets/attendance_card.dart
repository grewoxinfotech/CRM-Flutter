import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/hrm/attendance/controllers/attendance_controller.dart';
import 'package:crm_flutter/app/data/network/all/user_managemant/user_service.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/attendance/widget/graf_progress.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceCard extends StatelessWidget {

  final double? percentage;
  final GestureTapCallback? onPunchIn ;
  final GestureTapCallback? onPunchOut ;







  const AttendanceCard({super.key,
    required this.percentage,
    required this.onPunchIn,
    required this.onPunchOut,
  });

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());
    final UserService userService = Get.put(UserService());
    final user = userService.user.value;
    return GestureDetector(
      onTap: () => Get.to(AttendanceScreen()),
      child: CrmCard(
        padding: EdgeInsets.all(AppPadding.small),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          children: [
            const CrmHeadline(title: "Attendance"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // graf chart
                Padding(
                  padding: const EdgeInsets.all(AppPadding.medium),
                  child: GrafProgress(
                    percentage: percentage!,
                    width: AppPadding.medium * 4,
                  ),
                ),

                // buttons
                Column(
                  children: [
                    // punch in button
                    CrmButton(
                      title: "Punch In",
                      onTap: onPunchIn,
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

                    // punch out button
                    CrmButton(
                      title: "Punch Out",
                      onTap: onPunchOut,
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
          ],
        ),
      ),
    );
  }
}
