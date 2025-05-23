import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LeadOverviewCard extends StatelessWidget {
  final LeadModel lead;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const LeadOverviewCard({
    super.key,
    required this.lead,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;

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
                  '${lead.leadTitle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  "${lead.companyId}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                Text(
                  "id : ${lead.id}",
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
                  "${lead.clientId}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  "${lead.clientId}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                Text(
                  "id : ${lead.clientId}",
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
                items(Ic.mail, "${lead.clientId}"),
                items(Ic.call, "${{lead.clientId}}"),
                items(Ic.location, "${lead.clientId}"),
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
                  "${lead.currency}",
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                divider,
                tile(
                  "Lead Value",
                  "${lead.leadValue}",
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                divider,
                tile(
                  "Created",
                  formatDate(lead.createdAt.toString()),
                  Colors.purple,
                  FontAwesomeIcons.whatsapp,
                ),
                divider,
                tile(
                  "Interest Level",
                  lead.interestLevel.toString(),
                  Colors.red,
                  FontAwesomeIcons.facebookF,
                ),
                divider,
                tile(
                  "Lead Member",
                  lead.leadMembers.toString(),
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
                tile2("Pipeline", lead.pipeline.toString()),
                divider,
                tile2("Source", lead.source.toString()),
                divider,
                tile2("Category", lead.category.toString()),
                divider,
                tile2("Stage", lead.leadStage.toString()),
                divider,
                tile2("Status", lead.status.toString()),
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
