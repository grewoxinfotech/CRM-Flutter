import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LeadOverviewCard extends StatelessWidget {
  final LeadModel lead;

  const LeadOverviewCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    Widget iconTile(IconData icon, String value) {
      return Row(
        children: [
          Icon(icon, size: 16, color: textPrimary),
          AppSpacing.horizontalSmall,
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textSecondary,
            ),
          ),
        ],
      );
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

    List<Widget> item = [
      CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lead.leadTitle.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSmall,
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                iconTile(LucideIcons.mail, lead.clientId.toString()),
                iconTile(LucideIcons.phone, "123-456-7890"),
                iconTile(LucideIcons.mapPin, "New York"),
              ],
            ),
          ],
        ),
      ),
      CrmCard(
        padding: const EdgeInsets.all(AppPadding.small),
        child: Column(
          children: [
            _tile(
              title: "Lead Value",
              subtitle: "${lead.leadValue}.00",
              color: Colors.green.shade900,
              icon: LucideIcons.trendingUp,
            ),
            AppSpacing.verticalSmall,
            _tile(
              title: "Interest Level",
              subtitle: lead.interestLevel.toString(),
              color: interestColor(lead.interestLevel.toString()),
              icon: LucideIcons.flame,
            ),
            AppSpacing.verticalSmall,
            _tile(
              title: "Lead Member",
              subtitle: "${lead.leadMembers?.length ?? 0}",
              icon: LucideIcons.users2,
            ),
          ],
        ),
      ),
      CrmCard(
        padding: const EdgeInsets.all(AppPadding.small),
        child: Column(
          children: [
            _tile(
              title: "Pipeline",
              subtitle: "High",
              icon: LucideIcons.gitBranch,
            ),
            AppSpacing.verticalSmall,
            _tile(title: "Source", subtitle: "Hign", icon: LucideIcons.share2),
            AppSpacing.verticalSmall,
            _tile(
              title: "Category",
              subtitle: "medieya",
              icon: LucideIcons.tags,
            ),
            AppSpacing.verticalSmall,
            _tile(
              title: "Status",
              subtitle: "Hign",
              icon: LucideIcons.activity,
            ),
            AppSpacing.verticalSmall,
            _tile(
              title: "Stage",
              subtitle: "Stage",
              icon: LucideIcons.barChart3,
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CrmButton(
              height: 40,
              title: "Edit",
              onTap: () {},
              backgroundColor: surface,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: success,
              ),
            ),
          ),
          AppSpacing.horizontalSmall,
          Expanded(
            child: CrmButton(
              height: 40,
              title: "Delete",
              backgroundColor: surface,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: error,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    ];

    return ViewScreen(
      padding: const EdgeInsets.all(AppMargin.medium),
      itemCount: item.length,
      itemBuilder: (context, i) => item[i],
    );
  }
}

class _tile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? color;
  final IconData? icon;

  const _tile({super.key, this.icon, this.title, this.subtitle, this.color});

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      boxShadow: [],
      color: background,
      padding: EdgeInsets.all(AppPadding.small),
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: primary),
              AppSpacing.horizontalSmall,
              Text(
                title!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          AppSpacing.verticalSmall,
          Text(
            textAlign: TextAlign.end,
            subtitle!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color ?? Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
