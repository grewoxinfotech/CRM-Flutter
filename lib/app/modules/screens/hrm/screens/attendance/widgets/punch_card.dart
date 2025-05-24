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
                onTap: attendanceController.togglePunch,
                child: Row(
                  children: [
                    Text(
                      "Last ${attendanceController.punchTime}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color:
                            (attendanceController.isPunchedIn.value == true)
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                      ),
                    ),
                    AppSpacing.horizontalSmall,
                    CrmButton(
                      width: 60,
                      title:
                          (attendanceController.isPunchedIn.value == true)
                              ? "Out"
                              : "In",
                      onTap: attendanceController.togglePunch,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
