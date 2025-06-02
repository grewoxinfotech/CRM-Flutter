import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_call_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FollowUpCallCard extends StatelessWidget {
  final FollowUpCallModel? call;

  const FollowUpCallCard({super.key, this.call});

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: CrmIc(
                  icon: LucideIcons.phoneCall,
                  color: AppColors.primary,
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
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              CrmIc(icon: LucideIcons.moreVertical, color: AppColors.primary),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _tile(LucideIcons.circleDashed, "N/A"),
              _tile(LucideIcons.phone, "N/A"),
              _tile(LucideIcons.flag, "N/A"),
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
            SizedBox(width: 10),
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
