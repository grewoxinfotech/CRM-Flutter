import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/controllers/leave_controller.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/views/leave_overview_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;

  const LeaveCard({Key? key, required this.leave, this.onTap, this.onEdit})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = leave.id.toString();
    final String employeeId = leave.employeeId.toString();
    final String startDate = formatDate(leave.startDate.toString());
    final String endDate = formatDate(leave.endDate.toString());
    final String leaveType = leave.leaveType.toString();
    final String reason = leave.reason.toString();
    final String status = leave.status.toString();
    final String remarks = leave.remarks.toString();
    final String clientId = leave.clientId.toString();
    final String createdBy = leave.createdBy.toString();
    final String updatedBy = leave.updatedBy.toString();
    final String createdAt = leave.createdAt.toString();
    final String updatedAt = leave.updatedAt.toString();
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
        return AppColors.warning;
      } else if (status == "approved") {
        return AppColors.success;
      } else if (status == "rejected") {
        return AppColors.error;
      } else {
        return Colors.grey;
      }
    }

    return GestureDetector(
      onTap: () => Get.to(LeaveOverviewScreen() , arguments: leave),
      child: CrmCard(
        boxShadow: [],
        border: Border.all(color: AppColors.divider),
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
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
            Row(
              children: [
                Text(
                  "Half Day Application",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CrmStatusCard(title: status, color: statusColor(status)),
                AppSpacing.horizontalSmall,
                CrmStatusCard(
                  title: leaveType,
                  color: leaveTypeColor(leaveType),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
