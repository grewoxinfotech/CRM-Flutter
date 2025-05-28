import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/controllers/pipeline_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/controllers/stage_controller.dart';
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
    final PipelineController pipelineController = Get.put(PipelineController());
    final StageController stageController = Get.put(StageController());

    Color color = Colors.red;
    final String id = lead.id.toString();
    final String inquiryId = lead.inquiryId.toString();
    final String leadTitle = lead.leadTitle.toString();
    final String leadStage = stageController.getStageById(lead.status.toString());
    final String pipeline = pipelineController.getPipelineById(lead.pipeline.toString());;
    final String currency = lead.currency.toString();
    final String leadValue = lead.leadValue.toString();
    final String companyId = lead.companyId.toString();
    final String contactId = lead.contactId.toString();

    final int count = lead.leadMembers?.length ?? 0;
    final String leadMembers = count.toString();

    final String source = lead.source.toString();
    final String category = lead.category.toString();
    final String files = lead.files.toString();
    final String status = lead.status.toString();
    final String interestLevel = lead.interestLevel.toString();
    final String leadScore = lead.leadScore.toString();
    final String isConverted = lead.isConverted.toString();
    final String clientId = lead.clientId.toString();
    final String createdBy = formatDate(lead.createdBy.toString());
    final String updatedBy = formatDate(lead.updatedBy.toString());
    final String createdAt = formatDate(lead.createdAt.toString());
    final String updatedAt = formatDate(lead.updatedAt.toString());

    Widget space = Divider(height: AppPadding.small, color: divider);

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
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.end,
              subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
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
        children: [
          CrmCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leadTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),

                space,
                items(Ic.mail, clientId),
                items(Ic.call, clientId),
                items(Ic.location, clientId),
              ],
            ),
          ),
          AppSpacing.verticalSmall,
          CrmCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.small,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tile(
                  "Lead Value",
                  leadValue,
                  Colors.green,
                  FontAwesomeIcons.instagram,
                ),
                space,
                tile(
                  "Interest Level",
                  interestLevel,
                  Colors.red,
                  FontAwesomeIcons.facebookF,
                ),
                space,
                tile(
                  "Lead Member",
                  leadMembers ?? "0",
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
                tile2("Pipeline", pipeline),
                space,
                tile2("Source", source),
                space,
                tile2("Category", category),
                space,
                tile2("Stage", leadStage),
                space,
                tile2("Status", status),
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
