
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/controllers/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../../../../access/controller/access_controller.dart';
import '../../customer/controllers/customer_controller.dart'; // Your model file

class InvoiceDetailScreen extends StatelessWidget {
  final SalesInvoice invoice;
  final CustomerData? customer;

  const InvoiceDetailScreen({super.key, required this.invoice, this.customer});

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatAmount(double? value) {
    if (value == null) return "-";
    return "${invoice.currencyIcon ?? ''}${value.toStringAsFixed(2)}";
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Get.lazyPut(() => InvoiceController());
    final controller = Get.find<InvoiceController>();
    void _deleteCreditNote(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteInvoice(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Debit note deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice #${invoice.salesInvoiceNumber ?? '-'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // _generatePdf(context);
            },
          ),
          if (accessController.can(
            AccessModule.salesInvoice,
            AccessAction.delete,
          ))
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteCreditNote(
                  invoice.id ?? '',
                  invoice.salesInvoiceNumber ?? 'Credit Note',
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION: Invoice Information
            _buildSectionTitle("Invoice Information"),
            _buildRow("Invoice ID", invoice.salesInvoiceNumber ?? "-"),
            _buildRow("Issue Date", formatDate(invoice.issueDate.toString())),
            _buildRow("Due Date", formatDate(invoice.dueDate.toString())),
            _buildRow("Customer Name", customer?.customerNumber ?? "-"),

            const Divider(height: 24),

            // SECTION: Customer Information
            _buildSectionTitle("Customer Information"),
            _buildRow("Customer Name", customer?.name ?? "-"),
            _buildRow("GSTIN", customer?.taxNumber ?? "-"),
            _buildRow("Contact", customer?.contact ?? "-"),
            _buildRow(
              "Address",
              Address.formatAddress(customer?.billingAddress) ?? "-",
            ),

            const Divider(height: 24),


            // SECTION: Amounts
            _buildSectionTitle("Amounts"),
            _buildRow("Subtotal", _formatAmount(invoice.subtotal)),
            _buildRow("Discount", "-${_formatAmount(invoice.discount)}"),
            _buildRow("Tax", "+${_formatAmount(invoice.tax)}"),
            _buildRow("Total", _formatAmount(invoice.total)),
            _buildRow("Pending Amount", _formatAmount(invoice.pendingAmount)),
            _buildRow("Amount Paid", _formatAmount(invoice.amount)),

            const Divider(height: 24),

            // SECTION: Items List
            _buildSectionTitle("Invoice Items"),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2),
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Item",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Qty",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...invoice.items.map((item) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.name!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.quantity.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_formatAmount(item.total)),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            const Divider(height: 24),


            _buildSectionTitle("Scan to Pay / View Invoice"),
            Center(
              child: QrImageView(
                data:
                    invoice.upiLink ?? invoice.salesInvoiceNumber ?? "No data",
                version: QrVersions.auto,
                size: 180,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
