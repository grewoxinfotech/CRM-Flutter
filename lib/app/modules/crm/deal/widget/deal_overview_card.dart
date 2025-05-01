import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealOverviewCard extends StatelessWidget {
  final String? id;
  final Color? color;
  final String? dealTitle;
  final String? currency;
  final String? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final String? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final String? products;
  final String? files;
  final String? assignedTo;
  final String? clientId;
  final String? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const DealOverviewCard({
    super.key,
    this.id,
    this.color,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label, // ??
    this.closedDate, // ?
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    Widget divider = Divider(
      height: AppPadding.small,
      color: Get.theme.dividerColor,
    );

    Widget items(String iconPath, String title) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CrmIc(iconPath: iconPath, width: 12, color: color),
          Text(
            title.toString(),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: textSecondary,
            ),
          ),
        ],
      );
    }

    Widget tile(String title, String subtitle, Color color, icon) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      );
    }

    Widget tile2(String title, String subtitle) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            subtitle.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.verticalMedium,
          CrmCard(
            shadowColor: Get.theme.colorScheme.surface,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$dealTitle",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  "$companyName",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                Text(
                  "id : $id",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),

                Divider(
                  height: AppPadding.medium,
                  color: Get.theme.dividerColor,
                ),

                Text(
                  "$firstName $lastName",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  "$createdBy",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                Text(
                  "id : $clientId",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),

                Divider(
                  height: AppPadding.medium,
                  color: Get.theme.dividerColor,
                ),
                items(ICRes.mailSVG, email.toString()),
                items(ICRes.call, phone.toString()),
                items(ICRes.location, address.toString()),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
            shadowColor: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.large),
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tile(
                  "Currency",
                  currency.toString(),
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                divider,
                tile(
                  "Lead Value",
                  value.toString(),
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                divider,
                tile(
                  "Created",
                  formatDate(createdAt.toString()),
                  Colors.purple,
                  FontAwesomeIcons.whatsapp,
                ),
                divider,
                tile(
                  "Interest Level",
                  dealTitle.toString(),
                  Colors.red,
                  FontAwesomeIcons.facebookF,
                ),
                divider,
                tile(
                  "Deal Mamber",
                  dealTitle.toString(),
                  Colors.pink,
                  FontAwesomeIcons.google,
                ),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
            shadowColor: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.large),
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            child: Column(
              children: [
                tile2("Pipeline", pipeline.toString()),
                divider,
                tile2("Source", source.toString()),
                divider,
                tile2("Category", dealTitle.toString()),
                divider,
                tile2("Stage", stage.toString()),
                divider,
                tile2("Status", status.toString()),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CrmButton(
                  title: "Edit",
                  onTap: onEdit,
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: CrmButton(
                  title: "Delete",
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.error,
                  ),
                  onTap: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget items(String iconPath, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CrmIc(iconPath: iconPath, width: 14, color: Colors.grey.shade700),
      const SizedBox(width: 7),
      Text(
        title.toString(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    ],
  );
}

Widget tile(String title, String subtitle, Color color, icon, double? width) {
  return CrmCard(
    width: width,
    height: 70,
    padding: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(14),
    color: Get.theme.colorScheme.background,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color.withAlpha(200),
              ),
            ),
            Icon(icon, color: color.withAlpha(200), size: 18),
          ],
        ),
        Divider(height: 10, color: color.withAlpha(50)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color.withAlpha(255),
          ),
        ),
      ],
    ),
  );
}

Widget tile2(String title, String subtitle) {
  return CrmCard(
    height: 70,
    padding: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(14),
    color: Get.theme.colorScheme.background,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        Divider(height: 10, color: Get.theme.colorScheme.primary.withAlpha(50)),
        Text(
          subtitle.toString(),
          style: TextStyle(
            fontSize: 14,
            color: Get.theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
