import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealCard extends StatelessWidget {
  final DealModel deal;

  const DealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final Color color = primary;
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

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.dealDetail, arguments: deal),
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Title Row
            Row(
              children: [
                // Lead Title & Company Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dealTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                      Text(
                        companyName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSmall,
                // Value & Source
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$value.00',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    Text(
                      source,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Get.theme.dividerColor, height: AppPadding.medium),
            // Bottom Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(Ic.task, status, color),
                _infoTile(Ic.calendar, createdAt, color),
              ],
            ),
          ],
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
