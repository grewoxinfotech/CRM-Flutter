import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/controllers/attendance_controller.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PunchCard extends StatelessWidget {
  const PunchCard({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceController attendanceController = Get.put(AttendanceController());

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.attendance),
      child: Obx(
        () => CrmCard(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
          padding: EdgeInsets.all(
            AppPadding.small,
          ).copyWith(left: AppMargin.medium),
          color: white,
          border: Border.all(color: divider),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Punch :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: primary,
                ),
              ),
              Text(
                "Last ${attendanceController.punchTime}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color:
                      (attendanceController.isPunchedIn.value == true)
                          ? Colors.green.shade900
                          : Colors.red.shade900,
                ),
              ),
              CrmButton(
                width: 100,
                boxShadow: [
                  BoxShadow(
                    color: primary.withAlpha(100),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, 5),
                  ),
                ],
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: white,
                ),
                title:
                    (attendanceController.isPunchedIn.value == true)
                        ? "Out"
                        : "In",
                onTap: attendanceController.togglePunch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
