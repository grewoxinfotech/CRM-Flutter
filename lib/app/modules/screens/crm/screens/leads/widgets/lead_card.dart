import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LeadCard extends StatelessWidget {
  final LeadModel lead;

  const LeadCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    Color stageColor(String status) {
      switch (status.toLowerCase()) {
        case 'won':
          return AppColors.success;
        case 'lost':
          return AppColors.error;
        case 'in progress':
          return AppColors.warning;
        default:
          return Colors.grey;
      }
    }

    Color interestColor(String level) {
      switch (level.toLowerCase()) {
        case 'high':
          return AppColors.error;
        case 'medium':
          return AppColors.warning;
        case 'low':
          return AppColors.success;
        default:
          return Colors.grey;
      }
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.lead),
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        border: Border.all(color: AppColors.divider),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Lead Title & Company
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    lead.leadTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(LucideIcons.chevronRight, color: AppColors.divider),
              ],
            ),
SizedBox(height: 10,),
            /// Status Chips
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                CrmStatusCard(title: lead.source),
                CrmStatusCard(
                  title: lead.status,
                  color: stageColor(lead.status ?? ''),
                ),
                CrmStatusCard(
                  title: lead.interestLevel,
                  color: interestColor(lead.interestLevel ?? ''),
                ),
              ],
            ),
            SizedBox(height: 10,),


            /// Lead Value and Created Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs. ${lead.leadValue ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
                Row(
                  children: [
                    CrmIc(
                      icon: LucideIcons.calendar,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      formatDate(lead.createdAt.toString()),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
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
