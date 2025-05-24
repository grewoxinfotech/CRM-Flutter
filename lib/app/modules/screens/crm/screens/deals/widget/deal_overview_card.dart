import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DealOverviewCard extends StatelessWidget {
  final DealModel deal;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const DealOverviewCard({
    super.key,
    required this.deal,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color color = primary;
    final String id = deal.id.toString();
    final String dealTitle = deal.dealTitle.toString();
    final String currency = deal.currency.toString();
    final String value = deal.value.toString();
    final String pipeline = deal.pipeline.toString();
    final String stage = deal.stage.toString();
    final String status = deal.status.toString();
    final String label = deal.label.toString();
    final String closedDate = formatDate(deal.closedDate.toString());
    final String firstName = deal.firstName.toString();
    final String lastName = deal.lastName.toString();
    final String email = deal.email.toString();
    final String phone = deal.phone.toString();
    final String source = deal.source.toString();
    final String companyName = deal.companyName.toString();
    final String website = deal.website.toString();
    final String address = deal.address.toString();
    final String products = deal.products!.length.toString();
    final String files = deal.files!.length.toString();
    final String assignedTo = deal.assignedTo.toString();
    final String clientId = deal.clientId.toString();
    final String companyId = deal.companyId.toString();
    final String contactId = deal.contactId.toString();
    final String createdBy = deal.createdBy.toString();
    final String updatedBy = deal.updatedBy.toString();
    final String createdAt = formatDate(deal.createdAt.toString());
    final String updatedAt = formatDate(deal.updatedAt.toString());
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
                items(Ic.mail, email.toString()),
                items(Ic.call, phone.toString()),
                items(Ic.location, address.toString()),
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
