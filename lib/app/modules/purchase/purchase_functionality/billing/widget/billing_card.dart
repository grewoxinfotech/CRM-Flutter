import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

import '../../../../../care/constants/size_manager.dart';

class BillingCard extends StatelessWidget {
  final String? id;
  final String billNumber;

  final String totalAmount;
  final String? currency;
  final String? status;
  final String? issuedDate;
  final String? dueDate;
  final String? pendingAmount;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const BillingCard({
    Key? key,
    required this.id,
    required this.billNumber,

    required this.totalAmount,
    this.currency,
    this.status,
    this.issuedDate,
    this.dueDate,
    this.pendingAmount,
    this.onEdit,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              children: [
                // Icon
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(AppSpacing.extraLarge),
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.blueGrey[600],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bill Number & Status
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              billNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (status != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  status,
                                ).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(status),
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Customer Name
                      // Text(
                      //   customerName,
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.blueGrey,
                      //   ),
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      const SizedBox(height: 4),

                      // Total Amount
                      Text(
                        '₹ $totalAmount',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Dates
                      if (issuedDate != null || dueDate != null)
                        Row(
                          children: [
                            if (issuedDate != null)
                              Text(
                                'Issued: $issuedDate',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            if (issuedDate != null && dueDate != null)
                              const SizedBox(width: 12),
                            if (dueDate != null)
                              Text(
                                'Due: $dueDate',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),

                      // Pending Amount
                      if (pendingAmount != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Pending: ${currency ?? ''} $pendingAmount',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Actions
                if (onEdit != null || onDelete != null)
                  Column(
                    children: [
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: onEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      if (onDelete != null)
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: onDelete,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
