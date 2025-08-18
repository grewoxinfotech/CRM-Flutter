import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../data/network/sales/customer/service/customer_service.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class CustomerController extends PaginatedController<CustomerData> {
  final CustomerService _service = CustomerService();
  final String url = UrlRes.customers;
  var error = ''.obs;
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<CustomerData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchCustomers(page: page);
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

  Future<CustomerData?> getCustomerById(String id) async {
    try {
      final existingCustomer = items.firstWhereOrNull((item) => item.id == id);
      if (existingCustomer != null) {
        return existingCustomer;
      } else {
        final customer = await _service.getCustomerById(id);
        if (customer != null) {
          // items.add(customer);
          items.refresh();
        }
      }
    } catch (e) {
      print("Create customer error: $e");
    }
  }

  // --- CRUD METHODS ---
  Future<bool> createCustomer(CustomerData customer) async {
    try {
      final success = await _service.createCustomer(customer);
      if (success) {
        // Optionally reload the first page
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create customer error: $e");
      return false;
    }
  }

  Future<bool> updateCustomer(String id, CustomerData updatedCustomer) async {
    try {
      final success = await _service.updateCustomer(id, updatedCustomer);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedCustomer;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update customer error: $e");
      return false;
    }
  }

  Future<bool> deleteCustomer(String id) async {
    try {
      final success = await _service.deleteCustomer(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
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
}
