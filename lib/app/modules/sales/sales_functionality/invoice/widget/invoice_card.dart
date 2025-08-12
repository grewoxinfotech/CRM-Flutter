import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  final String? id;
  final String leadTitle;
  final String firstName;
  final String leadValue;
  final String? currency;
  final String? status;
  final String? createdAt;
  final String? dueDate;
  final String? pendingAmount;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const InvoiceCard({
    Key? key,
    required this.id,
    required this.leadTitle,
    required this.firstName,
    required this.leadValue,
    this.currency,
    this.status,
    this.createdAt,
    this.dueDate,
    this.pendingAmount,
    this.onEdit,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Invoice icon
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.blueGrey[50],
                  child: Icon(
                    Icons.receipt_long,
                    color: Colors.blueGrey[600],
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Invoice Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Invoice Number
                    Text(
                      leadTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Customer Name
                    Text(
                      firstName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Invoice Value
                    Text(
                      '${currency ?? ''} $leadValue',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Payment Status
                    if (status != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Status: $status',
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                status!.toLowerCase() == 'paid'
                                    ? Colors.green
                                    : Colors.orange,
                          ),
                        ),
                      ),

                    // Dates
                    if (createdAt != null)
                      Text(
                        'Issued: $createdAt',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    if (dueDate != null)
                      Text(
                        'Due: $dueDate',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),

                    // Pending Amount
                    if (pendingAmount != null)
                      Text(
                        'Pending: ${currency ?? ''} $pendingAmount',
                        style: const TextStyle(fontSize: 13, color: Colors.red),
                      ),
                  ],
                ),
              ),

              // Actions
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
