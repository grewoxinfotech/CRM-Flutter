import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/members/member_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;
  final VoidCallback? onTap;

  const MemberCard({super.key, required this.member, this.onTap});

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
                backgroundColor: AppColors.transparent,
                child: CrmIc(icon: LucideIcons.user, color: AppColors.primary),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member.firstName ?? ''} ${member.lastName ?? ''}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      member.designation ?? 'No Designation',
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
              CrmIc(icon: LucideIcons.chevronRight, color: AppColors.primary),
            ],
          ),
          AppSpacing.verticalSmall,
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _tile(LucideIcons.building2, member.department!),
              _tile(LucideIcons.badgeCheck, member.roleId!),
              _tile(LucideIcons.gitBranch, member.branch!),
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
