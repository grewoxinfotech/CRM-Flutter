import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/service/sales_invoice_service.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';

class SalesInvoiceController extends GetxController {
  final SalesInvoiceService salesInvoiceService = SalesInvoiceService();
  final SalesCustomerService salesCustomerService = SalesCustomerService();
  final RxBool isLoading = false.obs;
  final RxList<SalesInvoice> salesInvoices = <SalesInvoice>[].obs;
  final RxMap<String, SalesCustomer> customers = <String, SalesCustomer>{}.obs;
  final RxString currentDealId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    try {
      final customersList = await salesCustomerService.getSalesCustomers();
      customers.clear();
      for (var customer in customersList) {
        customers[customer.id] = customer;
      }
    } catch (e) {
      print('Error loading customers: $e');
    }
  }

  String getCustomerName(String customerId) {
    return customers[customerId]?.name ?? 'Unknown Customer';
  }

  Future<void> getSalesInvoices() async {
    try {
      isLoading.value = true;
      final invoices = await salesInvoiceService.getSalesInvoices();
      salesInvoices.assignAll(invoices);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch sales invoices: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSalesInvoicesByDealId(String dealId) async {
    try {
      isLoading.value = true;
      print('Fetching invoices for deal: $dealId');
      currentDealId.value = dealId;
      final invoices = await salesInvoiceService.getSalesInvoicesByDealId(dealId);
      print('Fetched ${invoices.length} invoices');
      salesInvoices.assignAll(invoices);
    } catch (e) {
      print('Error fetching invoices: $e');
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch sales invoices: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteSalesInvoice(String id) async {
    try {
      isLoading.value = true;
      final success = await salesInvoiceService.deleteSalesInvoice(id);

      if (success) {
        if (currentDealId.value.isNotEmpty) {
          await getSalesInvoicesByDealId(currentDealId.value);
        } else {
          await getSalesInvoices();
        }

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Sales invoice deleted successfully',
          contentType: ContentType.success,
        );
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete sales invoice: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateSalesInvoice(String id, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final response = await salesInvoiceService.updateSalesInvoice(id, data);
      
      if (response != null) {
        if (currentDealId.value.isNotEmpty) {
          await getSalesInvoicesByDealId(currentDealId.value);
        } else {
          await getSalesInvoices();
        }

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Invoice updated successfully',
          contentType: ContentType.success,
        );
        return true;
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update invoice',
        contentType: ContentType.failure,
      );
      return false;
    } catch (e) {
      print('Error updating sales invoice: $e');
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update invoice: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createSalesInvoice(String dealId, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final response = await salesInvoiceService.createSalesInvoice(dealId, data);
      
      if (response != null) {
        if (currentDealId.value.isNotEmpty) {
          await getSalesInvoicesByDealId(currentDealId.value);
        } else {
          await getSalesInvoices();
        }

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Invoice created successfully',
          contentType: ContentType.success,
        );
        return true;
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create invoice',
        contentType: ContentType.failure,
      );
      return false;
    } catch (e) {
      print('Error creating sales invoice: $e');
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create invoice: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 