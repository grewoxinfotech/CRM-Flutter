import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DealCard extends StatelessWidget {
  final DealModel deal;

  const DealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    Color stageColor(String status) {
      switch (status.toLowerCase()) {
        case 'won':
          return success;
        case 'lost':
          return error;
        case 'in progress':
          return warning;
        default:
          return Colors.grey;
      }
    }

    Color interestColor(String level) {
      switch (level.toLowerCase()) {
        case 'high':
          return error;
        case 'medium':
          return warning;
        case 'low':
          return success;
        default:
          return Colors.grey;
      }
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.dealDetail, arguments: deal),
      child: CrmCard(
        border: Border.all(color: divider),
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title & Company
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.dealTitle ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: divider),
              ],
            ),
            AppSpacing.verticalSmall,

            /// Chips (Pipeline, Stage, Interest)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                CrmStatusCard(title: deal.pipeline),
                CrmStatusCard(
                  title: deal.stage,
                  color: stageColor(deal.stage ?? ''),
                ),
                CrmStatusCard(
                  title: deal.source,
                  color: interestColor(deal.source ?? ''),
                ),
              ],
            ),
            AppSpacing.verticalSmall,

            /// Value & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${deal.currency ?? ''} ${deal.value ?? ''}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: success,
                  ),
                ),
                Row(
                  children: [
                    CrmIc(
                      icon: LucideIcons.calendar,
                      size: 14,
                      color: textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formatDate(deal.createdAt.toString()),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
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
