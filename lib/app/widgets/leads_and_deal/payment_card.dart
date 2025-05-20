import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCard extends StatelessWidget {
  final String? id;
  final String? project;
  final String? startDate;
  final String? endDate;
  final String? projectMembers;
  final String? completion;
  final String? status;
  final String? clientId;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const PaymentCard({
    super.key,
    this.id,
    this.project,
    this.startDate,
    this.endDate,
    this.projectMembers,
    this.completion,
    this.status,
    this.clientId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Color textPrimary = Get.theme.colorScheme.onPrimary;
    final Color textSecondary = Get.theme.colorScheme.onSecondary;
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Name & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project ?? "Untitled Project",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.small,
                    vertical: AppPadding.small / 2,
                  ),
                  decoration: BoxDecoration(
                    color: (status == "paid" ? Colors.green : Colors.orange)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Text(
                    status?.toUpperCase() ?? "UNPAID",
                    style: TextStyle(
                      fontSize: 12,
                      color: status == "paid" ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.verticalSmall,
            // Date Range
            Text(
              "Duration: ${startDate ?? '-'} to ${endDate ?? '-'}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),

            // Completion & Members
            Row(
              children: [
                Text(
                  "Completion: ${completion ?? '0%'}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                AppSpacing.horizontalSmall,
                Text(
                  "Members: ${projectMembers ?? '0'}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
              ],
            ),

            // Footer with created date and actions
            Divider(height: AppPadding.medium, color: Get.theme.dividerColor),

            // Edit / Delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CrmIc(
                  iconPath: Ic.edit,
                  onTap: onEdit,
                  color: success,
                ),
                AppSpacing.horizontalMedium,
                CrmIc(
                  iconPath: Ic.delete,
                  onTap: onDelete,
                  color: error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
