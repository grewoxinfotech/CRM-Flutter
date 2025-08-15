import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/network/sales/customer/service/customer_service.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/controllers/customer_controller.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';

import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import '../../../../../data/network/sales/revenue/model/revenue_menu.dart';
import '../../../../../data/network/sales/revenue/service/revenue_service.dart';

class RevenueController extends PaginatedController<RevenueData> {
  final RevenueService _service = RevenueService();
  final CustomerService customerService = CustomerService();

  var error = ''.obs;

  final List<CustomerData> customers = <CustomerData>[].obs;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<RevenueData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchRevenues(page: page);
      return response;
    } catch (e) {
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    Get.lazyPut<CustomerController>(() => CustomerController());
    final CustomerController customerController = Get.find();
    customerController.loadInitial();
    customers.assignAll(customerController.items);

    super.onInit();
    loadInitial();
  }

  Future<RevenueData?> getRevenueById(String id) async {
    try {
      final existingRevenue = items.firstWhereOrNull((item) => item.id == id);
      if (existingRevenue != null) {
        return existingRevenue;
      } else {
        final revenue = await _service.getRevenueById(id);
        if (revenue != null) {
          items.add(revenue);
          items.refresh();
        }
        return revenue;
      }
    } catch (e) {
      print("Get revenue by ID error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createRevenue(RevenueData revenue) async {
    try {
      final success = await _service.createRevenue(revenue);
      if (success) {
        await loadInitial(); // reload first page
      }
      return success;
    } catch (e) {
      print("Create revenue error: $e");
      return false;
    }
  }

  Future<bool> updateRevenue(String id, RevenueData updatedRevenue) async {
    try {
      final success = await _service.updateRevenue(id, updatedRevenue);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedRevenue;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update revenue error: $e");
      return false;
    }
  }

  Future<bool> deleteRevenue(String id) async {
    try {
      final success = await _service.deleteRevenue(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete revenue error: $e");
      return false;
    }
  }

  Future<String?> getCustomerById(String id) async {
    final exixtingCustomer = customers.firstWhereOrNull(
      (customer) => customer.id == id,
    );
    if (exixtingCustomer != null) {
      return exixtingCustomer.name;
    } else {
      final customer = await customerService.getCustomerById(id);

      if (customer != null) {
        customers.add(customer);

        return customer.name;
      }
      return null;
    }
  }
}
