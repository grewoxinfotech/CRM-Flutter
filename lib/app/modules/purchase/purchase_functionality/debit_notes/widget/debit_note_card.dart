import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

import '../../../../../care/constants/size_manager.dart';
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
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
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
