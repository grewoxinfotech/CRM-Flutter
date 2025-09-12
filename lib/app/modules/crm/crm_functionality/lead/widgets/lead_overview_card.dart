import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../access/controller/access_controller.dart';
import '../controllers/lead_controller.dart';

class LeadOverviewCard extends StatelessWidget {
  final String? id;
  final Color? color;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final String? leadValue;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? telephone;
  final String? email;
  final String? address;
  final String? leadMembers;
  final String? source;
  final String? category;
  final String? files;
  final String? status;
  final String? interestLevel;
  final String? leadScore;
  final String? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onConvert;

  const LeadOverviewCard({
    super.key,
    this.id,
    this.color,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.address,
    this.leadMembers,
    this.source,
    this.category,
    this.files,
    this.status,
    this.interestLevel,
    this.leadScore,
    this.isConverted,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onDelete,
    this.onEdit, this.onConvert,
  });

  String? _getCurrencyValue(LeadController leadController, String currencyId) {
    if (leadController.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (leadController.currencies.isNotEmpty) {
      final currencyExists = leadController.currencies.firstWhereOrNull(
        (c) => c.id == currencyId,
      );
      return currencyExists?.currencyCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accessController = Get.find<AccessController>();
    final LeadController leadController = Get.put(LeadController());

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
              fontSize: 14,
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
              fontSize: 14,
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
      padding: const EdgeInsets.all(AppMargin.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$leadTitle",
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
                items(ICRes.call, telephone.toString()),
                items(ICRes.location, address.toString()),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
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
                  _getCurrencyValue(leadController, currency.toString()) ??
                      'USD',
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                divider,
                tile(
                  "Lead Value",
                  leadValue.toString(),
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
                  interestLevel.toString(),
                  Colors.red,
                  FontAwesomeIcons.facebookF,
                ),
                divider,
                tile(
                  "Lead Member",
                  leadMembers.toString(),
                  Colors.pink,
                  FontAwesomeIcons.google,
                ),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
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
                tile2("Category", category.toString()),
                divider,
                tile2("Stage", leadStage.toString()),
                divider,
                tile2("Status", status.toString()),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (accessController.can(AccessModule.lead, AccessAction.update))
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
              if (accessController.can(AccessModule.lead, AccessAction.delete))
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
          if(isConverted!.toLowerCase() == "false")...[
            SizedBox(height: AppMargin.medium),
            CrmButton(
              width: double.infinity,
              title: "Convert to Deal",
              backgroundColor: Get.theme.colorScheme.surface,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorRes.primary,
              ),
              onTap: onConvert,
            ),
          ]

        ],
      ),
    );
  }
}
