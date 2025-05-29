import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/activity/activitie_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCard({super.key, required this.activity});

  IconData _getIcon(String? from) {
    switch (from) {
      case 'note':
        return LucideIcons.stickyNote;
      case 'lead_file':
        return LucideIcons.fileUp;
      case 'lead_member':
        return LucideIcons.userPlus;
      default:
        return LucideIcons.activity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.transparent,
                child: CrmIc(
                  icon: LucideIcons.messageSquare,
                  color: AppColors.error,
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.activityMessage ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.error,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      activity.performedBy ?? 'No Designation',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSmall,
              CrmStatusCard(title: activity.action,color: AppColors.error,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title) {
    return CrmCard(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      borderRadius: BorderRadius.circular(AppRadius.small),
      color: Colors.grey.withAlpha(50),
      boxShadow: [],
      child: FittedBox(
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.primary),
            AppSpacing.horizontalSmall,
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
