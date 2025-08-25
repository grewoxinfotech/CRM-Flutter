import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../data/network/sales_invoice/service/sales_invoice_service.dart';

class InvoiceController extends PaginatedController<SalesInvoice> {
  final SalesInvoiceService _service = SalesInvoiceService();
  final String url = UrlRes.salesInvoices;
  var error = ''.obs;

  RxMap<String, String> currencyIcons = <String, String>{}.obs;
  RxMap<String, String> currencyCodes = <String, String>{}.obs;
  final CurrencyController currencyController = Get.put(CurrencyController());

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<SalesInvoice>> fetchItems(int page) async {
    try {
      final response = await _service.fetchSalesInvoices(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }



  Future<void> getCurrencyById(String id) async {
    if (currencyIcons.containsKey(id)) return; // avoid duplicate API calls
    final currency = await currencyController.getCurrencyById(id);
    if (currency != null) {
      currencyIcons[id] = currency.currencyIcon;
      currencyCodes[id] = currency.currencyCode;
      currencyIcons.refresh();
      currencyCodes.refresh();
    }
  }




  Future<SalesInvoice?> getInvoiceById(String id) async {
    try {
      final existingInvoice = items.firstWhereOrNull((item) => item.id == id);
      if (existingInvoice != null) {
        return existingInvoice;
      } else {
        final invoice = await _service.getSalesInvoiceById(id);
        if (invoice != null) {
          items.add(invoice);
          items.refresh();
        }
      }
    } catch (e) {
      print("Get invoice error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createInvoice(SalesInvoice invoice, String dealId) async {
    try {
      final success = await _service.createSalesInvoice(invoice, dealId);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create invoice error: $e");
      return false;
    }
  }

  Future<bool> updateInvoice(
    String id,
    Map<String, dynamic> updatedInvoice,
  ) async {
    try {
      final success = await _service.updateSalesInvoice(id, updatedInvoice);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = SalesInvoice.fromJson(updatedInvoice);
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update invoice error: $e");
      return false;
    }
  }

  Future<bool> deleteInvoice(String id) async {
    try {
      final success = await _service.deleteSalesInvoice(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete invoice error: $e");
      return false;
    }
  }

  //
  // /// Extra helper to get customer name from customerId inside invoice
  // String getCustomerName(CustomerData? customer) {
  //   if (customer == null) return '';
  //   return '${customer.name}'.trim();
  // }
}
