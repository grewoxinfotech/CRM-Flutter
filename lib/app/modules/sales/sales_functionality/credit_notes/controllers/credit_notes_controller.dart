import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';

import '../../../../../data/network/sales/credit_notes/model/credit_notes_model.dart';
import '../../../../../data/network/sales/credit_notes/service/credit_notes_service.dart';
import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
import '../../invoice/controllers/invoice_controller.dart';

class CreditNoteController extends PaginatedController<CreditNoteData> {
  final CreditNoteService _service = CreditNoteService();
  final String url = UrlRes.creditNotes;
  var errorMessage = ''.obs;

  final RxList<SalesInvoice> invoices = <SalesInvoice>[].obs;



  @override
  Future<List<CreditNoteData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchCreditNotes(page: page);
      print("CreditNotes Response: ${response?.toJson()}");

      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch credit notes";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<InvoiceController>(() => InvoiceController());
    final invoiceController = Get.find<InvoiceController>();
    invoiceController.loadInitial();
    loadInitial();
  }

  /// Get single credit note by ID
  Future<CreditNoteData?> getCreditNoteById(String id) async {
    try {
      final existingNote = items.firstWhereOrNull((item) => item.id == id);
      if (existingNote != null) {
        return existingNote;
      } else {
        final creditNote = await _service.getCreditNoteById(id);
        if (creditNote != null) {
          items.add(creditNote);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get credit note error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createCreditNote(CreditNoteData creditNote) async {
    try {
      final success = await _service.createCreditNote(creditNote);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create credit note error: $e");
      return false;
    }
  }

  Future<bool> updateCreditNote(
    String id,
    CreditNoteData updatedCreditNote,
  ) async {
    try {
      final success = await _service.updateCreditNote(id, updatedCreditNote);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedCreditNote;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update credit note error: $e");
      return false;
    }
  }

  Future<bool> deleteCreditNote(String id) async {
    try {
      final success = await _service.deleteCreditNote(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete credit note error: $e");
      return false;
    }
  }
}
