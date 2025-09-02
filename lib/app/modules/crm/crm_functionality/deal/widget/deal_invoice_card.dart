import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/access_res.dart';

class DealInvoiceCard extends StatelessWidget {
  final String? id;
  final String? leadTitle; // Invoice Number
  final String? firstName; // Customer Name
  final String? createdAt; // Issue Date
  final String? dueDate; // Due Date
  final String? currency;
  final String? leadValue; // Total Amount
  final String? pendingAmount;
  final String? status;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const DealInvoiceCard({
    super.key,
    this.id,
    this.leadTitle,
    this.firstName,
    this.createdAt,
    this.dueDate,
    this.currency,
    this.leadValue,
    this.pendingAmount,
    this.status,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  String formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade600;
      case 'overdue':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accessController = Get.find<AccessController>();
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leadTitle ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        firstName ?? '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.onSurface.withOpacity(
                            0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status?.toUpperCase() ?? "UNPAID",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Details Grid
            Container(
              padding: const EdgeInsets.all(AppPadding.medium),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.small),
                border: Border.all(color: Get.theme.dividerColor, width: 1),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    'Issue Date',
                    formatDate(createdAt),
                    'Due Date',
                    formatDate(dueDate),
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    'Total Amount',
                    "${'₹'} ${leadValue ?? '0.00'}",
                    'Pending Amount',
                    "${'₹'} ${pendingAmount ?? '0.00'}",
                    firstValueColor: ColorRes.success,
                    secondValueColor: ColorRes.error,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (accessController.can(
                      AccessModule.deal,
                      AccessAction.update,
                    ) &&
                    accessController.can(
                      AccessModule.salesInvoice,
                      AccessAction.update,
                    ))
                  if (onEdit != null) ...[
                    _buildActionButton(
                      icon: ICRes.edit,
                      label: 'Edit',
                      onTap: onEdit,
                      color: ColorRes.success,
                    ),
                    const SizedBox(width: 12),
                  ],
                if (accessController.can(
                      AccessModule.deal,
                      AccessAction.delete,
                    ) &&
                    accessController.can(
                      AccessModule.salesInvoice,
                      AccessAction.delete,
                    ))
                  if (onDelete != null)
                    _buildActionButton(
                      icon: ICRes.delete,
                      label: 'Delete',
                      onTap: onDelete,
                      color: ColorRes.error,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String firstLabel,
    String firstValue,
    String secondLabel,
    String secondValue, {
    Color? firstValueColor,
    Color? secondValueColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                firstValue,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: firstValueColor ?? Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                secondLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                secondValue,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: secondValueColor ?? Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.small),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.small,
            vertical: AppPadding.small / 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CrmIc(iconPath: icon, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
