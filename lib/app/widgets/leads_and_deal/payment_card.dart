// widgets/payment_card.dart

import 'package:crm_flutter/app/data/network/all/project/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentCard extends StatelessWidget {
  final PaymentModel payment;
  const PaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Invoice: ${payment.invoice}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount: ₹${payment.amount.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16)),
                Text(
                  payment.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    color: payment.status == "paid"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text("Method: ${payment.paymentMethod}"),
            Text("Paid On: ${dateFormat.format(payment.paidOn)}"),
            if (payment.remark != null && payment.remark!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text("Remark: ${payment.remark!}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
          ],
        ),
      ),
    );
  }
}
