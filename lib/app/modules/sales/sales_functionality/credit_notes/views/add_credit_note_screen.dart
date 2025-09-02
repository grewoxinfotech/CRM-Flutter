import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/network/sales/credit_notes/model/credit_notes_model.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../invoice/controllers/invoice_controller.dart';
import '../controllers/credit_notes_controller.dart';

class AddCreditNoteScreen extends StatefulWidget {
  const AddCreditNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddCreditNoteScreen> createState() => _AddCreditNoteScreenState();
}

class _AddCreditNoteScreenState extends State<AddCreditNoteScreen> {
  final CreditNoteController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  // ✅ GetX Controller
  final InvoiceController invoiceController = Get.put(InvoiceController());

  SalesInvoice? selectedInvoice;

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  @override
  void initState() {
    super.initState();
    // ✅ Load invoices when screen opens
    invoiceController.loadInitial();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    currencyController.dispose();
    dateController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final creditNote = CreditNoteData(
      invoice: selectedInvoice!.id,
      customer: customerNameController.text,
      date: dateController.text,
      amount: amountController.text,
      description: descriptionController.text,
      currency: currencyController.text,
    );

    setState(() => isLoading = true);
    final success = await controller.createCreditNote(creditNote);

    setState(() => isLoading = false);
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Product added successfully"
              : "Failed to add product service",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>CustomerController());
    Get.lazyPut(()=>CurrencyController());
    final CustomerController customerController = Get.find();
    final CurrencyController _currencyController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Credit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,

          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              // ✅ Dropdown with live data from GetX
              Obx(() {
                final invoices =
                    invoiceController.items
                        .where((element) => element.paymentStatus == "unpaid")
                        .toList();
                return CrmDropdownField<SalesInvoice>(
                  title: 'Invoice',
                  value: selectedInvoice,
                  items:
                      invoices
                          .map(
                            (invoice) => DropdownMenuItem<SalesInvoice>(
                              value: invoice,
                              child: Text(
                                invoice.salesInvoiceNumber ?? 'No Number',
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (invoice) async{
                    if (invoice != null) {
                      final customer = await customerController.getCustomerById(invoice.customer);
                      final currency = await _currencyController.getCurrencyById(invoice.currency);
                        selectedInvoice = invoice;
                        customerNameController.text = customer?.name ?? '';
                        currencyController.text = currency?.currencyName ?? '';
                        amountController.text = invoice.total?.toString() ?? '';
                    setState(() {});
                    }
                  },
                  isRequired: true,
                  // validator:
                  //     (value) => requiredValidator(value, 'Customer Name'),
                );
              }),

              CrmTextField(
                controller: customerNameController,
                title: 'Customer Name',
                isRequired: true,
                enabled: false,
              ),
              CrmTextField(
                controller: currencyController,
                title: 'Currency',
                isRequired: true,
                enabled: false,
                validator: (value) => requiredValidator(value, 'Currency'),
              ),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: CrmTextField(
                    controller: dateController,
                    title: 'Date',
                    isRequired: true,
                    validator: (value) => requiredValidator(value, 'Date'),
                    onChanged: (value) {
                      // Revalidate only this field

                      if (_formKey.currentState != null) {
                        _formKey.currentState!.validate();
                      }
                    },
                  ),
                ),
              ),
              CrmTextField(
                controller: amountController,
                title: 'Amount',
                isRequired: true,
                enabled: false,
                keyboardType: TextInputType.number,
              ),
              CrmTextField(
                controller: descriptionController,
                title: 'Description',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CrmButton(onTap: _submit, title: 'Create Credit Note'),
            ],
          ),
        ),
      ),
    );
  }
}
