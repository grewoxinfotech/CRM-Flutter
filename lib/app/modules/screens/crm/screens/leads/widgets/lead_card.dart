import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class LeadCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? color;
  final String? id;
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

  const LeadCard({
    super.key,
    this.onTap,
    this.color,
    this.id,
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
  });

  @override
  Widget build(BuildContext context) {
    Color _getStageColor(String stage) {
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

    Color _getInterestColor(String level) {
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
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: surface,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          side: BorderSide(color: divider),
        ),
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
                          "Digital Marketing Campaign",
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
                              "Grewox Infotech",
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
                  _infoChip(Icons.public, "LinkedIn"),
                  AppSpacing.horizontalSmall,
                  _statusChip("won", _getStageColor("won")),
                  AppSpacing.horizontalSmall,
                  _statusChip("high", _getInterestColor("high")),
                ],
              ),

              // Bottom Row: Value + Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ 1200.00',
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
                        "05 May 2025",
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
