import 'package:crm_flutter/app/care/constants/access_res.dart';
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

class CustomerOverviewCard extends StatelessWidget {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final String? companyName;
  final String? totalOrders;
  final String? totalSpent;
  final String? createdAt;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const CustomerOverviewCard({
    super.key,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.companyName,
    this.totalOrders,
    this.totalSpent,
    this.createdAt,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    Widget divider = Divider(
      height: AppPadding.small,
      color: Get.theme.dividerColor,
    );

    Widget infoItem(String iconPath, String value) {
      return Row(
        children: [
          CrmIc(iconPath: iconPath, width: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    Widget statItem(String title, String value, Color color, IconData icon) {
      return Row(
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
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Info Card
          CrmCard(
            padding: const EdgeInsets.all(AppPadding.medium),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
                Text(
                  "ID: ${id ?? ''}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
                divider,
                Text(
                  "$firstName ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                divider,
                infoItem(ICRes.mailSVG, email ?? ''),
                infoItem(ICRes.call, phone ?? ''),
                infoItem(ICRes.location, address ?? ''),
              ],
            ),
          ),

          AppSpacing.verticalSmall,

          // Stats Card
          CrmCard(
            padding: const EdgeInsets.all(AppPadding.medium),
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                statItem(
                  "Total Orders",
                  totalOrders ?? '0',
                  Colors.blue,
                  FontAwesomeIcons.shoppingBag,
                ),
                divider,
                statItem(
                  "Total Spent",
                  totalSpent ?? '0',
                  Colors.green,
                  FontAwesomeIcons.dollarSign,
                ),
                divider,
                statItem(
                  "Created At",
                  formatDate(createdAt ?? ''),
                  Colors.purple,
                  FontAwesomeIcons.clock,
                ),
              ],
            ),
          ),

          AppSpacing.verticalSmall,

          // Action Buttons
          Row(
            children: [
              if (accessController.can(
                AccessModule.salesCustomer,
                AccessAction.update,
              ))
                Expanded(
                  child: CrmButton(
                    title: "Edit",
                    onTap: onEdit,
                    backgroundColor: Get.theme.colorScheme.surface,
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              AppSpacing.horizontalSmall,
              if (accessController.can(
                AccessModule.salesCustomer,
                AccessAction.delete,
              ))
                Expanded(
                  child: CrmButton(
                    title: "Delete",
                    onTap: onDelete,
                    backgroundColor: Get.theme.colorScheme.surface,
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.error,
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
