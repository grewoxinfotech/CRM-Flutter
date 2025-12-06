import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/data/network/purchase/billing/model/billing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/input/crm_date_picker.dart';
import '../controller/debit_note_controller.dart';

class AddDebitNoteScreen extends StatelessWidget {
  final DebitNoteController controller = Get.find<DebitNoteController>();

  AddDebitNoteScreen({Key? key}) : super(key: key);

  String? amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter amount';
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value.trim())) {
      return 'Enter a valid amount';
    }
    return null;
  }

  String? reasonValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter reason';
    return null;
  }

  Widget _buildBillField() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmDropdownField<BillingData>(
            title: 'Select Bill',
            value: controller.selectedBill.value,
            items:
                controller.bills.map((bill) {
                  return DropdownMenuItem<BillingData>(
                    value: bill,
                    child: Text('${bill.billNumber} (${bill.amount})'),
                  );
                }).toList(),
            onChanged: (selectedBill) {
              if (selectedBill != null) {
                controller.billIdController.text = selectedBill.id ?? '';
                controller.amountController.text =
                    selectedBill.amount?.toString() ?? '0';
                controller.selectedBill.value = selectedBill;
                controller.selectedCurrency.value = selectedBill.currency ?? '';
              }
            },
            isRequired: true,
          ),

          const SizedBox(height: 8),
          Text(
            'Bill Date: ${formatDateString(controller.selectedBill.value!.billDate) ?? ''}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pre-fill date if empty
    if (controller.dateController.text.isEmpty) {
      controller.dateController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
    }

    // Pre-fill currency default if empty
    if ((controller.selectedCurrency.value ?? '').isEmpty &&
        controller.currencies.isNotEmpty) {
      controller.selectedCurrency.value = controller.currencies.first;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Debit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Bill Dropdown
                _buildBillField(),

                const SizedBox(height: 20),

                /// Amount
                CrmTextField(
                  controller: controller.amountController,
                  title: 'Amount',
                  keyboardType: TextInputType.number,
                  validator: amountValidator,
                  hintText: 'Enter amount',
                ),
                const SizedBox(height: 20),

                /// Reason
                CrmTextField(
                  controller: controller.reasonController,
                  title: 'Reason / Description',
                  maxLines: 2,
                  validator: reasonValidator,
                  hintText: 'Enter reason',
                ),
                const SizedBox(height: 20),

                /// Date & Currency Row
                Row(
                  children: [
                    Expanded(
                      child: CrmDatePicker(
                        controller: controller.dateController,
                        label: 'Select Date',
                        hint: 'Choose Date',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /// Submit Button
                Obx(
                  () =>
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CrmButton(
                            width: Get.width - 40,
                            title: 'Add Debit Note',
                            onTap: () => controller.submitDebitNote(),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
