import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';

class CompanyOverviewCard extends StatelessWidget {
  final String? id;
  final Color? color;
  final String? companyName;
  final String? accountOwner;
  final String? email;
  final String? phoneNumber;
  final String? billingAddress;
  final String? website;
  final String? companyRevenue;
  final String? companyCategory;
  final String? companyType;
  final String? createdBy;
  final String? createdAt;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const CompanyOverviewCard({
    super.key,
    this.id,
    this.color,
    this.companyName,
    this.accountOwner,
    this.email,
    this.phoneNumber,
    this.billingAddress,
    this.website,
    this.companyRevenue,
    this.companyCategory,
    this.companyType,
    this.createdBy,
    this.createdAt,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    Widget divider = Divider(
      height: AppPadding.small,
      color: Get.theme.dividerColor,
    );

    Widget infoRow(String iconPath, String content) {
      return Row(
        children: [
          CrmIc(iconPath: iconPath, width: 14, color: color ?? Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 14, color: textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    Widget tile(String title, String subtitle, Color color, IconData icon) {
      return CrmCard(
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        color: Get.theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color.withAlpha(200),
                  ),
                ),
                Icon(icon, size: 18, color: color.withAlpha(200)),
              ],
            ),
            Divider(height: 10, color: color.withAlpha(50)),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmCard(
            padding: const EdgeInsets.all(AppPadding.medium),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: $id',
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
                divider,
                Text(
                  accountOwner ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                Text(
                  'Created by: $createdBy',
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
                divider,
                infoRow(ICRes.mailSVG, email ?? ''),
                infoRow(ICRes.call, phoneNumber ?? ''),
                infoRow(ICRes.location, billingAddress ?? ''),
                infoRow(ICRes.location, website ?? ''),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
            padding: const EdgeInsets.all(AppPadding.medium),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              children: [
                tile(
                  'Revenue',
                  companyRevenue ?? '-',
                  Colors.green,
                  FontAwesomeIcons.dollarSign,
                ),
                const SizedBox(height: 10),
                tile(
                  'Category',
                  companyCategory ?? '-',
                  Colors.orange,
                  FontAwesomeIcons.layerGroup,
                ),
                const SizedBox(height: 10),
                tile(
                  'Type',
                  companyType ?? '-',
                  Colors.purple,
                  FontAwesomeIcons.building,
                ),
                const SizedBox(height: 10),
                tile(
                  'Created At',
                  formatDate(createdAt ?? ''),
                  Colors.blue,
                  FontAwesomeIcons.clock,
                ),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          Row(
            children: [
              Expanded(
                child: CrmButton(
                  title: 'Edit',
                  onTap: onEdit,
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: CrmButton(
                  title: 'Delete',
                  onTap: onDelete,
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    color: Get.theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
