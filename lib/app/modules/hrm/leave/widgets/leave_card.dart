import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/color_res.dart';
import '../../../../care/constants/ic_res.dart';
import '../../../../care/constants/size_manager.dart';
import '../../../../widgets/common/display/crm_card.dart';
import '../../../../widgets/common/display/crm_ic.dart';
import '../../../hrm/leave/controllers/leave_controller.dart';

class LeaveCard extends StatelessWidget {
  final String employeeName;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String status;
  final String reason;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LeaveCard({
    Key? key,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.reason,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<LeaveController>(() => LeaveController());
    final LeaveController controller = Get.find();

    Color? onPrimary = Get.theme.colorScheme.onPrimary;
    Color? onSecondary = Get.theme.colorScheme.onSecondary;
    Color? primary = Get.theme.colorScheme.primary;

    Widget tile(String title, String subTitle) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: onPrimary,
          ),
          children: [
            TextSpan(text: "$title : "),
            TextSpan(
              text: subTitle,
              style: TextStyle(
                color: onSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }


    final List<LeaveColorModel> leaveColors = LeaveColorModel.getLeaves();

    return CrmCard(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Employee name and leave type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                employeeName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: onPrimary,
                ),
              ),
              CrmCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.small,
                  vertical: AppPadding.small / 2,
                ),
                boxShadow: [],
                color: controller.getStatusColor(status).withAlpha(30),
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: Text(
                  status,
                  style: TextStyle(
                    color: controller.getStatusColor(status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSmall,

          tile("Start Day", startDate),
          tile("End Day", endDate),
          (reason.isNotEmpty) ? tile("Reason", reason) : SizedBox(),

          AppSpacing.verticalMedium,

          // Status and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CrmCard(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.small,
                  vertical: AppPadding.small / 2,
                ),
                boxShadow: [],
                color: controller.getLeaveTypeColor(leaveType).withAlpha(30),
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: Text(
                  leaveType,
                  style: TextStyle(
                    fontSize: 14,
                    color: controller.getLeaveTypeColor(leaveType),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Row(
                children: [
                  CrmIc(
                    iconPath: ICRes.edit,
                    color: success,
                    onTap: onEdit,
                  ),
                  AppSpacing.horizontalMedium,
                  CrmIc(
                    iconPath: ICRes.delete,
                    color: error,
                    onTap: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
