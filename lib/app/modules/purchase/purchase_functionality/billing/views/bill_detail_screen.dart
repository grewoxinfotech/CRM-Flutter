import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/data/network/purchase/billing/model/billing_model.dart';
import 'package:crm_flutter/app/data/network/purchase/vendor/model/vendor_model.dart';
import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../../../../access/controller/access_controller.dart';
import '../../vendor/contoller/vendor_controller.dart';
import '../controllers/billing_controller.dart';

class BillDetailScreen extends StatefulWidget {
  final BillingData bill;
  VendorData? vendor;

  BillDetailScreen({super.key, required this.bill, this.vendor});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  @override
  void initState() {
    getVendor();
    super.initState();
  }

  Future<void> getVendor() async {
    final vendorController = Get.put(VendorController());

    try {
      // Ensure vendors are loaded
      if (vendorController.items.isEmpty) {
        await vendorController.loadInitial();
      }

      // Find vendor based on bill.vendor (NOT bill.id)
      final selectedVendor = vendorController.items.firstWhereOrNull(
        (element) => element.id == widget.bill.vendor,
      );

      if (selectedVendor != null) {
        setState(() {
          widget.vendor = selectedVendor; // update vendor reference
        });
      }
    } catch (e) {
      debugPrint("Error fetching vendor: $e");
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatAmount(double? value) {
    if (value == null) return "-";
    return "${widget.bill.currencyIcon ?? ''}${value.toStringAsFixed(2)}";
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
          const SizedBox(width: 12),
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

    Get.lazyPut(() => BillingController());
    final BillingController controller = Get.find();
    void _deleteCreditNote(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteBill(id);
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
        title: Text("${widget.bill.billNumber ?? '-'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Download PDF / Export logic here
            },
          ),
          if (accessController.can(
            AccessModule.purchaseBilling,
            AccessAction.update,
          ))
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteCreditNote(
                  widget.bill.id ?? '',
                  widget.bill.billNumber ?? 'Credit Note',
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
            // SECTION: Bill Information
            _buildSectionTitle("Bill Information"),
            _buildRow("Bill ID", widget.bill.billNumber ?? "-"),
            _buildRow(
              "Bill Date",
              formatDate(widget.bill.billDate?.toString() ?? ''),
            ),
            _buildRow("Vendor", widget.vendor?.name ?? "-"),

            const Divider(height: 24),

            // SECTION: Vendor Information
            _buildSectionTitle("Vendor Information"),
            _buildRow("Name", widget.vendor?.name ?? "-"),
            _buildRow("GSTIN", widget.vendor?.taxNumber ?? "-"),
            _buildRow("Contact", widget.vendor?.contact ?? "-"),

            _buildRow(
              "Address",
              Address.formatAddress(
                    Address(
                      city: widget.vendor?.city,
                      country: widget.vendor?.city,
                      postalCode: widget.vendor?.zipcode,
                      state: widget.vendor?.state,
                      street: widget.vendor?.address,
                    ),
                  ) ??
                  "-",
            ),
            const Divider(height: 24),

            // SECTION: Amounts
            _buildSectionTitle("Amounts"),
            _buildRow("Subtotal", _formatAmount(widget.bill.subTotal)),
            _buildRow("Discount", "-${_formatAmount(widget.bill.discount)}"),
            _buildRow("Tax", "+${_formatAmount(widget.bill.tax)}"),
            _buildRow("Total", _formatAmount(widget.bill.total)),

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
                ...widget.bill.items!.map((item) {
                  return TableRow(
                    children: [
                      Obx(() {
                        controller.getProduct(widget.bill.items!);
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
                data:
                    widget.bill.upiLink ?? widget.bill.billNumber ?? "No data",
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
