import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/members/member_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MemberCard extends StatelessWidget {
  final MemberModel? member;
  final VoidCallback? onTap;

  const MemberCard({super.key,this.member, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: CrmIc(icon: LucideIcons.user, color: AppColors.primary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "N/A N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
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
              CrmIc(icon: LucideIcons.chevronRight, color: AppColors.primary),
            ],
          ),
          _tile(LucideIcons.building2, "N/A"),
          _tile(LucideIcons.badgeCheck, "N/A"),
          _tile(LucideIcons.gitBranch, "N/A"),
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
