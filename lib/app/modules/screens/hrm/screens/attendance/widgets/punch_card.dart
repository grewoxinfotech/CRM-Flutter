import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PunchCard extends StatelessWidget {
  final String? punchTime;
  final bool? isPunchIn;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onPunch;

  const PunchCard({
    super.key,
    this.punchTime,
    this.isPunchIn,
    this.onTap,
    this.onPunch,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(AttendanceScreen()),
      child: CrmCard(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.medium),
        color: white,
        border: Border.all(color: divider),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Punch :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
            GestureDetector(
              onTap: onPunch,
              child: Row(
                children: [
                  Text(
                    "Last $punchTime",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color:
                          (isPunchIn == true)
                              ? Colors.green.shade900
                              : Colors.red.shade900,
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  CrmButton(
                    width: 60,
                    title: (isPunchIn == true) ? "Out" : "In",
                    onTap: onPunch,
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
