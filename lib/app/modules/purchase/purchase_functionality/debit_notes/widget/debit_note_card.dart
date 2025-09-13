// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../care/constants/size_manager.dart';
// import '../../../../../data/network/purchase/debit_notes/model/debit_node_model.dart';
//
// class DebitNoteCard extends StatelessWidget {
//   final DebitNote debitNote;
//   final UpdatedBill updatedBill;
//
//   const DebitNoteCard({
//     Key? key,
//     required this.debitNote,
//     required this.updatedBill,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: CrmCard(
//         padding: const EdgeInsets.all(AppPadding.medium),
//         margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
//         borderRadius: BorderRadius.circular(AppRadius.large),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Date: ${debitNote.date}"),
//             Text("Amount: ${debitNote.amount}"),
//             Text("Description: ${debitNote.description}"),
//             const Divider(),
//             Text("Debited Amount: ${updatedBill.debitedAmount}"),
//             Text("Total Debited Amount: ${updatedBill.totalDebitedAmount}"),
//             Text("Status: ${updatedBill.newStatus}"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/purchase/debit_notes/model/debit_node_model.dart';

class DebitNoteCard extends StatefulWidget {
  final DebitNote debitNote;
  final UpdatedBill updatedBill;

  const DebitNoteCard({
    Key? key,
    required this.debitNote,
    required this.updatedBill,
  }) : super(key: key);

  @override
  State<DebitNoteCard> createState() => _DebitNoteCardState();
}

class _DebitNoteCardState extends State<DebitNoteCard> {
  @override
  void initState() {
    Get.put(CurrencyController()).getCurrency();
    super.initState();
  }

  String formatCurrency(double? amount) {
    if (amount != null) {
      return amount.toStringAsFixed(2);
    }
    return '';
  }

  String formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      } catch (e) {
        return date; // fallback if parsing fails
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final CurrencyController currencyController = Get.find();
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          children: [
            // Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.red[100],
                child: Icon(
                  Icons.attach_money,
                  color: Colors.red[700],
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Debit Note Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Debit Note ID
                  Text(
                    "DN-${widget.debitNote.id ?? ''}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Date
                  if (widget.debitNote.date != null)
                    Text(
                      "Date: ${formatDate(widget.debitNote.date)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                  // Amount
                  if (widget.debitNote.amount != null)
                    Obx(() {
                      final currency = currencyController.currencyModel
                          .firstWhereOrNull(
                            (c) => c.id == widget.debitNote.currency.trim(),
                          );
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Amount: ${currency?.currencyIcon ?? ''} ${formatCurrency(widget.debitNote.amount.toDouble() ?? 0)}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),

                  // Description
                  if (widget.debitNote.description != null &&
                      widget.debitNote.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Description: ${widget.debitNote.description}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Updated Bill Details
                  // Text(
                  //   "Debited: ${formatCurrency(updatedBill.debitedAmount)}",
                  //   style: const TextStyle(fontSize: 13, color: Colors.black87),
                  // ),
                  // Text(
                  //   "Total Debited: ${formatCurrency(updatedBill.totalDebitedAmount)}",
                  //   style: const TextStyle(fontSize: 13, color: Colors.black87),
                  // ),
                  // Text(
                  //   "Status: ${updatedBill.newStatus ?? '-'}",
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     color:
                  //         updatedBill.newStatus == "Paid"
                  //             ? Colors.green[700]
                  //             : Colors.orange[700],
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
