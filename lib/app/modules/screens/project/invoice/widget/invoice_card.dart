// widgets/invoice_card.dart

import 'package:crm_flutter/app/data/network/all/project/invoice/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(invoice.salesInvoiceNumber,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Issue: ${dateFormat.format(invoice.issueDate)}"),
                Text("Due: ${dateFormat.format(invoice.dueDate)}"),
              ],
            ),
            const SizedBox(height: 6),
            Text("Total: ₹${invoice.total.toStringAsFixed(2)}"),
            Text("Status: ${invoice.paymentStatus.toUpperCase()}",
                style: TextStyle(
                    color: invoice.paymentStatus == "paid"
                        ? Colors.green
                        : Colors.orange)),
            if (invoice.upiLink.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text("UPI: ${invoice.upiLink}",
                    style: const TextStyle(fontSize: 12, color: Colors.blue)),
              ),
          ],
        ),
      ),
    );
  }
}
