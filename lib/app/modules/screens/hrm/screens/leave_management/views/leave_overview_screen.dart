import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/controllers/leave_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveOverviewScreen extends StatelessWidget {
  const LeaveOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveModel leave = Get.arguments;

    final String id = leave.id.toString();
    final String employeeId = leave.employeeId.toString();
    final String startDate = formatDate(leave.startDate.toString());
    final String endDate = formatDate(leave.endDate.toString());
    final String leaveType = leave.leaveType.toString();
    final String reason = leave.reason.toString();
    final String status = leave.status.toString();
    final String remarks = leave.remarks.toString();
    final String isHalfDay = leave.isHalfDay.toString();
    final String clientId = leave.clientId.toString();
    final String createdBy = formatDate(leave.createdBy.toString());
    final String updatedBy = formatDate(leave.updatedBy.toString());
    final String createdAt = formatDate(leave.createdAt.toString());
    final String updatedAt = formatDate(leave.updatedAt.toString());

    Color leaveTypeColor(String leaveType) {
      return LeaveColorModel.getLeaves()
          .firstWhere(
            (e) => e.leaveType.toLowerCase() == leaveType.toLowerCase(),
            orElse: () => LeaveColorModel(leaveType: '', color: Colors.grey),
          )
          .color;
    }

    Color statusColor(String status) {
      if (status == "pending") {
        return warning;
      } else if (status == "approved") {
        return success;
      } else if (status == "rejected") {
        return error;
      } else {
        return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(leaveType)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CrmCard(
              height: 150,
              width: 150,
              borderRadius: BorderRadius.circular(1000),
              alignment: Alignment.center,
              child: CrmIc(
                iconPath: Ic.mention,
                color: statusColor(status),
                width: 100,
              ),
            ),
            AppSpacing.verticalMedium,
            CrmStatusCard(
              title: status,
              color: statusColor(status),
              fontSize: 20,
            ),
            AppSpacing.verticalMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      color: textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(text: startDate),
                      TextSpan(
                        text:
                            (endDate.toString().isEmpty || startDate == endDate)
                                ? ""
                                : " - $endDate",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.verticalMedium,
            Text(
              reason,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
            AppSpacing.verticalMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CrmButton(
                      title: "Edit",
                      onTap: () {},
                      backgroundColor: Get.theme.colorScheme.surface,
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  Expanded(
                    child: CrmButton(
                      title: "Delete",
                      backgroundColor: Get.theme.colorScheme.surface,
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Get.theme.colorScheme.error,
                      ),
                      onTap: () {},
                    ),
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
