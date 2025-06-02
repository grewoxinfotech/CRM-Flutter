import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class DealOverviewCard extends StatelessWidget {
  final DealModel deal;

  const DealOverviewCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    Widget iconTile(IconData icon, String value) {
      return Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          SizedBox(width: 10,),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }

    List<Widget> item = [
      CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deal.dealTitle ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color:AppColors. textPrimary,
              ),
            ),
            SizedBox(width: 10,),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                iconTile(LucideIcons.mail, deal.clientId ?? 'N/A'),
                iconTile(LucideIcons.phone, "123-456-7890" ?? 'N/A'),
                iconTile(LucideIcons.mapPin, "New York" ?? 'N/A'),
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
              title: "Value",
              subtitle: "${deal.value} ${deal.currency ?? ''}",
              icon: LucideIcons.trendingUp,
              color: Colors.green.shade800,
            ),
            SizedBox(width: 10,),
            _tile(
              title: "Status",
              subtitle: deal.status ?? '',
              icon: LucideIcons.activity,
            ),
            SizedBox(width: 10,),
            _tile(
              title: "Label",
              subtitle: deal.label ?? '',
              icon: LucideIcons.tag,
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
              subtitle: deal.pipeline ?? '',
              icon: LucideIcons.gitBranch,
            ),
            SizedBox(width: 10,),
            _tile(
              title: "Stage",
              subtitle: deal.stage ?? '',
              icon: LucideIcons.barChart3,
            ),
            SizedBox(width: 10,),
            _tile(
              title: "Source",
              subtitle: deal.source ?? '',
              icon: LucideIcons.share2,
            ),
            SizedBox(height: 10,),
            _tile(
              title: "Closed Date",
              subtitle: deal.closedDate != null
                  ? DateFormat('dd MMM yyyy').format(deal.closedDate!)
                  : 'N/A',
              icon: LucideIcons.calendar,
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
              backgroundColor:AppColors. surface,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: CrmButton(
              height: 40,
              title: "Delete",
              backgroundColor: AppColors.surface,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.error,
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
      color: AppColors.background,
      padding: EdgeInsets.all(AppPadding.small),
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.primary),
              SizedBox(width: 10,),
              Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Text(
            subtitle ?? '',
            textAlign: TextAlign.end,
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
