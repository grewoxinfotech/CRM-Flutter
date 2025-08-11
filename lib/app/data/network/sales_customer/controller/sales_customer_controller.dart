import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/data/network/sales_customer/service/sales_customer_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class SalesCustomerController extends GetxController {
  final SalesCustomerService salesCustomerService = SalesCustomerService();
  final RxList<SalesCustomer> customers = <SalesCustomer>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
  }

  Future<void> getCustomers() async {
    try {
      isLoading.value = true;
      final customersList = await salesCustomerService.getSalesCustomers();
      customers.assignAll(customersList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load customers: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<SalesCustomer?> getCustomerById(String id) async {
    try {
      isLoading.value = true;
      return await salesCustomerService.getSalesCustomer(id);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load customer: $e',
        contentType: ContentType.failure,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createCustomer(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await salesCustomerService.createSalesCustomer(data);
      
      if (result != null) {
        await getCustomers();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Customer created successfully',
          contentType: ContentType.success,
        );
      return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create customer: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateCustomer(String id, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await salesCustomerService.updateSalesCustomer(id, data);
      
      if (result != null) {
        await getCustomers();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Customer updated successfully',
          contentType: ContentType.success,
        );
      return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update customer: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCustomer(String id) async {
    try {
      isLoading.value = true;
      final result = await salesCustomerService.deleteSalesCustomer(id);
      
      if (result) {
        await getCustomers();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Customer deleted successfully',
          contentType: ContentType.success,
        );
      return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete customer: $e',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 