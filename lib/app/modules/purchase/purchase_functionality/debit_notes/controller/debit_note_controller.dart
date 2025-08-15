import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/purchase/debit_notes/service/debit_note_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/purchase/debit_notes/model/debit_node_model.dart';

class DebitNoteController extends GetxController {
  final DebitNoteService _service = DebitNoteService();
  var isLoading = false.obs;
  var debitNotes = <DebitNoteItem>[].obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final amountController = TextEditingController();
  final billIdController = TextEditingController();
  final dateController = TextEditingController();


  // New: Date & Currency
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<String?> selectedCurrency = Rx<String?>(null);
  final List<String> currencies = ['INR', 'USD', 'EUR'];

  static Future<Map<String, String>> headers() async => await UrlRes.getHeaders();

  @override
  void onInit() {
    super.onInit();
    fetchAllDebitNotes();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

  }

  @override
  void onClose() {
    reasonController.dispose();
    amountController.dispose();
    billIdController.dispose();
    super.onClose();
  }

  /// Refresh debit notes list
  Future<void> refreshDebitNotes() async {
    try {
      isLoading.value = true;
      final response = await _service.getAllDebitNotes();
      debitNotes.assignAll(response);
    } catch (e) {
      print("Refresh debit notes error: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to refresh debit notes: ${e.toString()}",
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }


  /// Fetch all debit notes
  Future<void> fetchAllDebitNotes() async {
    try {
      isLoading.value = true;
      final response = await _service.getAllDebitNotes();
      debitNotes.assignAll(response);
    } catch (e) {
      print("Fetch all debit notes error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit a new debit note
  Future<void> submitDebitNote() async {
    // Sync selectedDate with dateController

    print('Final Bill ID: ${billIdController.text}');

    if (dateController.text.isNotEmpty) {
      try {
        selectedDate.value = DateFormat('yyyy-MM-dd').parse(dateController.text);
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
      isLoading.value = true;

      final payload = {
        'bill': billIdController.text.trim(),
        'description': reasonController.text.trim(),
        'amount': double.tryParse(amountController.text.trim())?.toInt() ?? 0,
        'date': selectedDate.value!.toIso8601String(),
        'currency': selectedCurrency.value!,
      };




      print('CONTROLLER_DEBUG${billIdController.text.trim()}');

      final result = await _service.createDebitNote(payload);

      if (result['success'] == true) {
        await fetchAllDebitNotes();
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
    } finally {
      isLoading.value = false;
    }
  }


  /// Delete a debit note
  Future<bool> deleteDebitNote(String id) async {
    try {
      final success = await _service.deleteDebitNote(id);
      if (success) {
        debitNotes.removeWhere((item) => item.debitNote.id == id);
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
    return debitNotes.firstWhereOrNull((item) => item.debitNote.id == id);
  }
}
