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

  var errorMessage = ''.obs;
  final customers = <CustomerData>[].obs;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<RevenueData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchRevenues(page: page);
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch revenues";
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

    loadInitial();
  }

  Future<RevenueData?> getRevenueById(String id) async {
    try {
      final existingRevenue = items.firstWhereOrNull((item) => item.id == id);
      if (existingRevenue != null) return existingRevenue;

      final revenue = await _service.getRevenueById(id);
      if (revenue != null) {
        items.add(revenue);
        items.refresh();
      }
      return revenue;
    } catch (e) {
      errorMessage.value = "Get revenue by ID error: $e";
      return null;
    }
  }

  Future<bool> createRevenue(RevenueData revenue) async {
    try {
      final success = await _service.createRevenue(revenue);
      if (success) await loadInitial();
      return success;
    } catch (e) {
      errorMessage.value = "Create revenue error: $e";
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
      errorMessage.value = "Update revenue error: $e";
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
      errorMessage.value = "Delete revenue error: $e";
      return false;
    }
  }

  Future<String?> getCustomerById(String id) async {
    final existingCustomer = customers.firstWhereOrNull(
      (customer) => customer.id == id,
    );

    if (existingCustomer != null) return existingCustomer.name;

    final customer = await customerService.getCustomerById(id);
    if (customer != null) {
      customers.add(customer);
      return customer.name;
    }
    return null;
  }
}
