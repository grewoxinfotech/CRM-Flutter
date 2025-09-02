import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/controllers/customer_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/sales/credit_notes/model/credit_notes_model.dart';

class CreditNoteCard extends StatelessWidget {
  final CreditNoteData creditNote;

  const CreditNoteCard({Key? key, required this.creditNote}) : super(key: key);

  String formatCreditNoteName(String? name) {
    if (name != null && name.isNotEmpty) {
      return name.length <= 6 ? name : name.substring(name.length - 6);
    } else {
      return '';
    }
  }

  String formatCurrency(double? amount) {
    if (amount != null) {
      return amount.toStringAsFixed(2);
    } else {
      return '';
    }
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MM-yyyy').format(date);
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SalesInvoiceController>(() => SalesInvoiceController());
    final SalesInvoiceController controller = Get.find();
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              children: [
                // Icon Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.orange[100],
                    child: Icon(
                      Icons.receipt_long,
                      color: Colors.orange[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Credit Note Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Credit Note Number
                      Text(
                        "CN-${formatCreditNoteName(creditNote.id)}" ??
                            'Unnamed Credit Note',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Customer Name
        if (creditNote.invoice != null && creditNote.invoice!.isNotEmpty)
    FutureBuilder(
      future: controller.getInvoiceById(creditNote.invoice!),
      builder: (context, snapshot) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CrmLoadingCircle());
          }

          final SalesInvoice invoice = controller.invoices.firstWhereOrNull((invoice) => invoice.id == creditNote.invoice!)??SalesInvoice(items: []);
          if (invoice == null) {
            return const Text(
              "Loading invoice...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            );
          }

          return Text(
            invoice.salesInvoiceNumber ?? 'Unknown Invoice',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blueGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        });
      },
    ),
    const SizedBox(height: 4),

                      // Date
                      if (creditNote.createdAt != null)
                        Text(
                          'Date: ${formatDate(DateTime.parse(creditNote.createdAt!))}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),

                      // Amount
                      if (creditNote.amount != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            'Amount: ${formatCurrency(double.parse(creditNote.amount!) ?? 0)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
