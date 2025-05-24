import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadCard extends StatelessWidget {
  final LeadModel lead;
  final Color? color;

  const LeadCard({super.key, required this.lead, this.color});

  @override
  Widget build(BuildContext context) {
    final String id = lead.id.toString();
    final String inquiryId = lead.inquiryId.toString();
    final String leadTitle = lead.leadTitle.toString();
    final String leadStage = lead.leadStage.toString();
    final String pipeline = lead.pipeline.toString();
    final String currency = lead.currency.toString();
    final String leadValue = lead.leadValue.toString();
    final String companyId = lead.companyId.toString();
    final String contactId = lead.contactId.toString();
    final String leadMembers = lead.leadMembers.toString();
    final String source = lead.source.toString();
    final String category = lead.category.toString();
    final String files = lead.files.toString();
    final String status = lead.status.toString();
    final String interestLevel = lead.interestLevel.toString();
    final String leadScore = lead.leadScore.toString();
    final String isConverted = lead.isConverted.toString();
    final String clientId = formatDate(lead.clientId.toString());
    final String createdBy = formatDate(lead.createdBy.toString());
    final String updatedBy = formatDate(lead.updatedBy.toString());
    final String createdAt = formatDate(lead.createdAt.toString());
    final String updatedAt = formatDate(lead.updatedAt.toString());

    Color stageColor(String stage) {
      switch (stage.toLowerCase()) {
        case 'won':
          return success;
        case 'lost':
          return error;
        case 'in progress':
          return warning;
        default:
          return grey;
      }
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
          return grey;
      }
    }

    Widget _infoChip(IconData icon, String text) {
      return Row(
        children: [
          Icon(icon, size: 14, color: textPrimary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
        ],
      );
    }

    Widget _statusChip(String label, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.small,
          vertical: AppPadding.small / 2,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.leadDetail, arguments: lead ),
      child: CrmCard(
        margin: EdgeInsets.zero,
        color: surface,
        border: Border.all(color: divider),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leadTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              companyId,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  _infoChip(Icons.public, files),
                  AppSpacing.horizontalSmall,
                  _statusChip(status, stageColor(status)),
                  AppSpacing.horizontalSmall,
                  _statusChip(interestLevel, interestColor(interestLevel)),
                ],
              ),

              // Bottom Row: Value + Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    leadValue,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: success,
                    ),
                  ),
                  Row(
                    children: [
                      CrmIc(
                        iconPath: Ic.calendar,
                        width: 14,
                        color: textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String iconPath, String? title, Color? iconColor) {
    return Row(
      children: [
        CrmIc(iconPath: iconPath, width: 14, color: iconColor),
        const SizedBox(width: AppPadding.small),
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
