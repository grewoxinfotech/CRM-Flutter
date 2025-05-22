import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_text_button.dart';
import 'package:crm_flutter/app/widgets/input/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/input/crm_date_picker.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';

class InvoiceEditDialog extends StatelessWidget {
  final SalesInvoice invoice;
  final SalesInvoiceController controller;
  final VoidCallback onSuccess;

  const InvoiceEditDialog({
    Key? key,
    required this.invoice,
    required this.controller,
    required this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize text controllers with existing values
    final invoiceNumberController = TextEditingController(text: invoice.salesInvoiceNumber);
    final totalController = TextEditingController(text: invoice.total.toString());
    final pendingController = TextEditingController(text: invoice.pendingAmount?.toString() ?? '0');
    final issueDateController = TextEditingController(text: invoice.issueDate.toIso8601String());
    final dueDateController = TextEditingController(text: invoice.dueDate.toIso8601String());

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.large),
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Invoice',
              style: Get.textTheme.titleLarge,
            ),
            SizedBox(height: AppSpacing.large),
            CrmTextField(
              controller: invoiceNumberController,
              label: 'Invoice Number',
              hint: 'Enter invoice number',
            ),
            SizedBox(height: AppSpacing.medium),
            Row(
              children: [
                Expanded(
                  child: CrmTextField(
                    controller: totalController,
                    label: 'Total Amount',
                    hint: 'Enter total amount',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: CrmTextField(
                    controller: pendingController,
                    label: 'Pending Amount',
                    hint: 'Enter pending amount',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.medium),
            Row(
              children: [
                Expanded(
                  child: CrmDatePicker(
                    controller: issueDateController,
                    label: 'Issue Date',
                    hint: 'Select issue date',
                  ),
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: CrmDatePicker(
                    controller: dueDateController,
                    label: 'Due Date',
                    hint: 'Select due date',
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.large),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CrmTextButton(
                  onPressed: () => Get.back(),
                  text: 'Cancel',
                  type: CrmTextButtonType.secondary,
                ),
                const SizedBox(width: AppSpacing.medium),
                Obx(() => CrmTextButton(
                  onPressed: controller.isLoading.value 
                    ? null 
                    : () async {
                        // Prepare items array in the exact format needed
                        final itemsList = invoice.items.map((item) => {
                          'product_id': item.productId,
                          'name': item.name,
                          'quantity': item.quantity,
                          'unit_price': item.unitPrice,
                          'tax': item.tax,
                          'tax_amount': item.taxAmount,
                          'discount': item.discount,
                          'discount_type': item.discountType,
                          'hsn_sac': item.hsnSac,
                          'amount': item.amount
                        }).toList();

                        final success = await controller.updateSalesInvoice(
                          invoice.id,
                          {
                            'category': invoice.category,
                            'customer': invoice.customer,
                            'section': 'sales-invoice',
                            'issueDate': issueDateController.text.split('T')[0],  // Get only the date part
                            'dueDate': dueDateController.text.split('T')[0],      // Get only the date part
                            'currency': invoice.currency,
                            'items': itemsList,
                            'subtotal': invoice.subtotal,
                            'tax': invoice.tax,
                            'discount': invoice.discount,
                            'total': double.tryParse(totalController.text) ?? 0.0,
                            'payment_status': invoice.paymentStatus,
                            'additional_notes': '',
                            'salesInvoiceNumber': invoiceNumberController.text,
                            'pendingAmount': double.tryParse(pendingController.text) ?? 0.0,
                          },
                        );
                        
                        if (success) {
                          onSuccess();
                          Navigator.of(context).pop();
                        }
                      },
                  text: controller.isLoading.value ? 'Saving...' : 'Save Changes',
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 