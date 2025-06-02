import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/network/all/project/activity/activitie_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel? activity;

  const ActivityCard({super.key, this.activity});

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
                child: CrmIc(
                  icon: LucideIcons.messageSquare,
                  color: AppColors.error,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.error,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "N/A",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
