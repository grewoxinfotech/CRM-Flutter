

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/purchase/billing/model/billing_model.dart';
import 'package:crm_flutter/app/data/network/purchase/debit_notes/model/debit_node_model.dart';
import 'package:crm_flutter/app/data/network/purchase/debit_notes/service/debit_note_service.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/billing/controllers/billing_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DebitNoteController extends PaginatedController<DebitNoteItem> {
  final DebitNoteService _service = DebitNoteService();
  final BillingController billingController = Get.put(BillingController());

  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final amountController = TextEditingController();
  final billIdController = TextEditingController();
  final dateController = TextEditingController();

  Rxn<BillingData> selectedBill = Rxn<BillingData>();
  Rx<DateTime?> selectedDate = Rxn<DateTime?>(null);
  Rx<String?> selectedCurrency = Rx<String?>(null);

  List<String> currencies = ['INR', 'USD', 'EUR'];
  RxList<BillingData> bills = <BillingData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    loadBills();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void onClose() {
    reasonController.dispose();
    amountController.dispose();
    billIdController.dispose();
    dateController.dispose();
    super.onClose();
  }

  @override
  Future<List<DebitNoteItem>> fetchItems(int page) async {
    try {
      final response = await _service.fetchDebitNotes(page: page);
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to fetch debit notes",
          contentType: ContentType.failure,
        );
        return [];
      }
    } catch (e) {
      print("Exception in fetchItems: $e");
      return [];
    }
  }

  /// Refresh debit notes list
  Future<void> refreshDebitNotes() async {
    await refreshList();
  }

  /// Load all bills
  Future<void> loadBills() async {
    await billingController.loadInitial();
    bills.assignAll(billingController.items.where((b) => b.amount! > 0));
    if (bills.isNotEmpty) {
      selectedBill.value = bills.first;
      billIdController.text = bills.first.id ?? '';
      amountController.text = bills.first.amount?.toString() ?? '0';
    }
  }

  /// Submit a new debit note
  Future<void> submitDebitNote() async {
    if (dateController.text.isNotEmpty) {
      try {
        selectedDate.value = DateFormat(
          'yyyy-MM-dd',
        ).parse(dateController.text);
      } catch (_) {
        selectedDate.value = null;
      }
    }

    if (!formKey.currentState!.validate() ||
        selectedDate.value == null ||
        selectedCurrency.value == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Validation Error",
        message: "Please fill all required fields, including Date & Currency",
        contentType: ContentType.warning,
      );
      return;
    }

    try {
      final payload = {
        'bill': billIdController.text.trim(),
        'description': reasonController.text.trim(),
        'amount': double.tryParse(amountController.text.trim())?.toInt() ?? 0,
        'date': selectedDate.value!.toIso8601String(),
        'currency': selectedCurrency.value!,
      };

      final result = await _service.createDebitNote(payload);

      if (result['success'] == true) {
        await loadInitial();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: result['message'] ?? "Debit note added successfully",
          contentType: ContentType.success,
        );
        Get.back(result: true);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: result['message'] ?? "Failed to add debit note",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "An unexpected error occurred: ${e.toString()}",
        contentType: ContentType.failure,
      );
    }
  }

  /// Delete a debit note
  Future<bool> deleteDebitNote(String id) async {
    try {
      final success = await _service.deleteDebitNote(id);
      if (success) {
        items.removeWhere((item) => item.debitNote.id == id);
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete debit note: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Find a debit note by ID
  DebitNoteItem? findDebitNoteById(String id) {
    return items.firstWhereOrNull((item) => item.debitNote.id == id);
  }
}
