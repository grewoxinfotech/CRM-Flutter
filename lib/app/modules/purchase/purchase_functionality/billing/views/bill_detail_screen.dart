import 'package:crm_flutter/app/data/network/purchase/billing/model/billing_model.dart';
import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../controllers/billing_controller.dart';

class BillDetailScreen extends StatelessWidget {
  final BillingData bill;
  final CustomerData? vendor;

  const BillDetailScreen({super.key, required this.bill, this.vendor});

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatAmount(double? value) {
    if (value == null) return "-";
    return "${bill.currencyIcon ?? ''}${value.toStringAsFixed(2)}";
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
          const SizedBox(width: 8),
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
    Get.lazyPut(() => BillingController());
    final BillingController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill #${bill.billNumber ?? '-'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Download PDF / Export logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION: Bill Information
            _buildSectionTitle("Bill Information"),
            _buildRow("Bill ID", bill.billNumber ?? "-"),
            _buildRow("Bill Date", formatDate(bill.billDate?.toString() ?? '')),
            _buildRow("Vendor", vendor?.name ?? "-"),

            const Divider(height: 24),

            // SECTION: Vendor Information
            _buildSectionTitle("Vendor Information"),
            _buildRow("Name", vendor?.name ?? "-"),
            _buildRow("GSTIN", vendor?.taxNumber ?? "-"),
            _buildRow("Contact", vendor?.contact ?? "-"),
            _buildRow(
              "Address",
              Address.formatAddress(vendor?.billingAddress) ?? "-",
            ),

            const Divider(height: 24),

            // SECTION: Amounts
            _buildSectionTitle("Amounts"),
            _buildRow("Subtotal", _formatAmount(bill.subTotal)),
            _buildRow("Discount", "-${_formatAmount(bill.discount)}"),
            _buildRow("Tax", "+${_formatAmount(bill.tax)}"),
            _buildRow("Total", _formatAmount(bill.total)),

            // _buildRow("Pending Amount", _formatAmount(bill.pendingAmount)),
            // _buildRow("Amount Paid", _formatAmount(bill.amountPaid)),
            const Divider(height: 24),

            // SECTION: Items List
            _buildSectionTitle("Bill Items"),
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
                ...bill.items!.map((item) {
                  return TableRow(
                    children: [
                      Obx(() {
                        controller.getProduct(bill.items!);
                        print("[DEBUG]=> ${controller.products.length}");
                        final product = controller.products.firstWhereOrNull(
                          (element) => element.id == item.productId,
                        );
                        return Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text(product?.name ?? "-"),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.quantity.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_formatAmount(item.amount)),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            const Divider(height: 24),

            // SECTION: QR Code
            _buildSectionTitle("Scan to View Bill"),
            Center(
              child: QrImageView(
                data: bill.upiLink ?? bill.billNumber ?? "No data",
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
