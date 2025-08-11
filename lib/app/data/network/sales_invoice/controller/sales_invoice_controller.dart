import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/service/sales_invoice_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // Added for jsonDecode
import 'package:http/http.dart' as http; // Added for http

class SalesInvoiceController extends GetxController {
  final SalesInvoiceService salesInvoiceService = SalesInvoiceService();
  final SalesCustomerService salesCustomerService = SalesCustomerService();

  final RxList<SalesInvoice> invoices = <SalesInvoice>[].obs;
  final RxList<SalesCustomer> customers = <SalesCustomer>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    try {
      isLoading.value = true;
      final customersList = await salesCustomerService.getSalesCustomers();

      if (customersList.isEmpty) {
        // Log warning but don't show error to user
        print(
          'Warning: No customers found. This may cause issues when displaying invoice details.',
        );
      }

      customers.assignAll(customersList);
    } catch (e) {
      // Log error but don't show to user unless explicitly requested
      print('Error loading customers: $e');

      // Try to load from cache or use existing data if available
      if (customers.isEmpty) {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Warning',
          message:
              'Could not load customer data. Some invoice information may be incomplete.',
          contentType: ContentType.warning,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Get customer name by ID
  String getCustomerName(String customerId) {
    if (customerId.isEmpty) {
      return 'Unknown Customer';
    }

    try {
      // Check if customers are loaded
      if (customers.isEmpty) {
        // Try to load customers if not already loading
        if (!isLoading.value) {
          loadCustomers();
        }
        return 'Loading...';
      }

      final customer = customers.firstWhereOrNull((c) => c.id == customerId);
      if (customer != null) {
        return customer.name ?? 'Unknown Customer';
      }

      // If customer not found in list, return ID as fallback
      return 'Customer #$customerId';
    } catch (_) {
      return 'Customer #$customerId';
    }
  }

  // Fetch invoices for a specific deal
  Future<List<SalesInvoice>> fetchInvoicesForDeal(String dealId) async {
    try {
      isLoading.value = true;
      final invoicesList = await salesInvoiceService.getSalesInvoicesByDealId(
        dealId,
      );
      invoices.assignAll(invoicesList);
      return invoicesList;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch invoices: $e',
        contentType: ContentType.failure,
      );
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  // Get a single invoice by ID
  Future<SalesInvoice?> getInvoiceById(String id) async {
    try {
      isLoading.value = true;
      return await salesInvoiceService.getSalesInvoiceById(id);
    } finally {
      isLoading.value = false;
    }
  }

  // Calculate total amount for all invoices
  double calculateTotalAmount() {
    return invoices.fold(0.0, (sum, invoice) => sum + (invoice.amount ?? 0.0));
  }

  // Calculate total paid amount
  double calculateTotalPaid() {
    return invoices.fold(
      0.0,
      (sum, invoice) =>
          sum +
          (invoice.paymentStatus == 'paid' ? (invoice.amount ?? 0.0) : 0.0),
    );
  }

  // Calculate total unpaid amount
  double calculateTotalUnpaid() {
    return invoices.fold(
      0.0,
      (sum, invoice) =>
          sum +
          (invoice.paymentStatus == 'unpaid' ? (invoice.amount ?? 0.0) : 0.0),
    );
  }

  // Update an invoice
  Future<bool> updateInvoice(String id, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await salesInvoiceService.updateSalesInvoice(id, data);

      if (result) {
        // Refresh the invoices list if update was successful
        if (invoices.isNotEmpty) {
          final dealId = invoices.first.relatedId;
          if (dealId != null) {
            await fetchInvoicesForDeal(dealId);
          }
        }

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Invoice updated successfully',
          contentType: ContentType.success,
        );
        return true;
      }
      return false;
    } catch (e) {
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

  // Create a new invoice
  Future<bool> createInvoice(SalesInvoice data, String dealId) async {
    try {
      isLoading.value = true;
      final result = await salesInvoiceService.createSalesInvoice(data, dealId);

      if (result) {
        // Refresh the invoices list if creation was successful
        await fetchInvoicesForDeal(dealId);

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Invoice created successfully',
          contentType: ContentType.success,
        );
        return true;
      }
      return false;
    } catch (e) {
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

  // Delete an invoice
  Future<bool> deleteInvoice(String id) async {
    try {
      isLoading.value = true;

      // Make DELETE request to the API
      final response = await http.delete(
        Uri.parse("${salesInvoiceService.url}/$id"),
        headers: await SalesInvoiceService.headers(),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          // Remove the invoice from the local list
          invoices.removeWhere((invoice) => invoice.id == id);

          CrmSnackBar.showAwesomeSnackbar(
            title: 'Success',
            message: 'Invoice deleted successfully',
            contentType: ContentType.success,
          );
          return true;
        }
      }

      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete invoice',
        contentType: ContentType.failure,
      );
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete invoice: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
