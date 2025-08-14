import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/contoller/vendor_controller.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/views/update_vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class VendorDetailScreen extends StatefulWidget {
  VendorData vendor;

  VendorDetailScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorDetailScreen> createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  final VendorController vendorController = Get.find<VendorController>();

  String _formatText(String? value) => value == null || value.isEmpty ? "-" : value;

  Widget _buildSectionTitle(String title) => Padding(
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

  Widget _buildRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
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

  void _deleteVendor() {
    Get.dialog(
      CrmDeleteDialog(
        entityType: widget.vendor.name,
        onConfirm: () async {
          final success = await vendorController.deleteVendor(widget.vendor.id!);
          if (success) {
            Get.back(); // go back to vendor list
            CrmSnackBar.showAwesomeSnackbar(
              title: "Success",
              message: "Vendor deleted successfully",
              contentType: ContentType.success,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vendor.name ?? "Vendor Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedVendor =
              await Get.to(() => UpdateVendorScreen(vendor: widget.vendor));
              if (updatedVendor != null) {
                setState(() {
                  widget.vendor = updatedVendor; // refresh UI
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteVendor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Basic Information"),
            _buildRow("Vendor Name", _formatText(widget.vendor.name)),
            _buildRow("Contact", _formatText(widget.vendor.contact)),
            _buildRow("Email", _formatText(widget.vendor.email)),
            _buildRow("Phone Code", _formatText(widget.vendor.phonecode)),
            const Divider(height: 24),
            _buildSectionTitle("Address Information"),
            _buildRow("Address", _formatText(widget.vendor.address)),
            _buildRow("City", _formatText(widget.vendor.city)),
            _buildRow("State", _formatText(widget.vendor.state)),
            _buildRow("Country", _formatText(widget.vendor.country)),
            _buildRow("Zipcode", _formatText(widget.vendor.zipcode)),
            const Divider(height: 24),
            _buildSectionTitle("Tax Information"),
            _buildRow("Tax Number", _formatText(widget.vendor.taxNumber)),
            const Divider(height: 24),
            _buildSectionTitle("Metadata"),
            _buildRow("Created By", _formatText(widget.vendor.createdBy)),
            _buildRow("Updated By", _formatText(widget.vendor.updatedBy)),
            _buildRow("Created At", _formatText(widget.vendor.createdAt)),
            _buildRow("Updated At", _formatText(widget.vendor.updatedAt)),
          ],
        ),
      ),
    );
  }
}
