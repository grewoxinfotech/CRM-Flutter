import 'package:flutter/material.dart';

import '../../../../../data/network/purchase/debit_notes/model/debit_node_model.dart';

class DebitNoteCard extends StatelessWidget {
  final DebitNote debitNote;
  final UpdatedBill updatedBill;

  const DebitNoteCard({
    Key? key,
    required this.debitNote,
    required this.updatedBill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${debitNote.date}"),
            Text("Amount: ${debitNote.amount}"),
            Text("Description: ${debitNote.description}"),
            const Divider(),
            Text("Debited Amount: ${updatedBill.debitedAmount}"),
            Text("Total Debited Amount: ${updatedBill.totalDebitedAmount}"),
            Text("Status: ${updatedBill.newStatus}"),
          ],
        ),
      ),
    );
  }
}
