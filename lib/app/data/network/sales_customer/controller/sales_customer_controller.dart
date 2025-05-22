import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:get/get.dart';

class SalesCustomerController extends GetxController {
  final _salesCustomerService = SalesCustomerService();
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final salesCustomers = <SalesCustomer>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSalesCustomers();
  }

  Future<void> getSalesCustomers() async {
    try {
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;
      final customers = await _salesCustomerService.getSalesCustomers();
      salesCustomers.assignAll(customers);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load customers. Please check your connection and try again.';
      print('Error loading customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<SalesCustomer?> getSalesCustomer(String id) async {
    try {
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;
      return await _salesCustomerService.getSalesCustomer(id);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load customer details. Please try again.';
      print('Error loading customer: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createSalesCustomer(Map<String, dynamic> data) async {
    try {
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;
      await _salesCustomerService.createSalesCustomer(data);
      await getSalesCustomers(); // Refresh list
      return true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to create customer. Please try again.';
      print('Error creating customer: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateSalesCustomer(String id, Map<String, dynamic> data) async {
    try {
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;
      await _salesCustomerService.updateSalesCustomer(id, data);
      await getSalesCustomers(); // Refresh list
      return true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to update customer. Please try again.';
      print('Error updating customer: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteSalesCustomer(String id) async {
    try {
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;
      await _salesCustomerService.deleteSalesCustomer(id);
      await getSalesCustomers(); // Refresh list
      return true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to delete customer. Please try again.';
      print('Error deleting customer: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 