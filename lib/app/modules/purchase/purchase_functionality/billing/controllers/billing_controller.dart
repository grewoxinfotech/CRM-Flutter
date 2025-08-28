import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/url_res.dart';

import '../../../../../data/network/purchase/billing/model/billing_model.dart';
import '../../../../../data/network/purchase/billing/service/billing_service.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../sales/sales_functionality/products_services/controllers/product_service_controller.dart';

class BillingController extends PaginatedController<BillingData> {
  final BillingService _service = BillingService();
  final String url = UrlRes.billing;
  var error = ''.obs;
  List<Data> products = <Data>[].obs;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<BillingData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchBills(page: page);
      return response?.data ?? [];
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

  /// Fetch a single bill by ID, from cache if available
  Future<BillingData?> getBillById(String id) async {
    try {
      final existingBill = items.firstWhereOrNull((item) => item.id == id);
      if (existingBill != null) {
        return existingBill;
      } else {
        // You might want to implement getBillById in BillingService
        final billList = await _service.fetchBills(id: id);
        if (billList != null && billList.data.isNotEmpty) {
          final bill = billList.data.first;
          items.add(bill);
          items.refresh();
          return bill;
        }
      }
    } catch (e) {
      print("Get bill error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createBill(BillingData bill, String userId) async {
    try {
      final success = await _service.createBill(bill, userId);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create bill error: $e");
      return false;
    }
  }

  Future<bool> updateBill(String id, BillingData updatedBill) async {
    try {
      final success = await _service.updateBill(id, updatedBill);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedBill;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update bill error: $e");
      return false;
    }
  }

  Future<bool> deleteBill(String id) async {
    try {
      final success = await _service.deleteBill(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete bill error: $e");
      return false;
    }
  }

  Future<void> getProduct(List<BillingItem> items) async {
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    final controller = Get.find<ProductsServicesController>();
    for (int i = 0; i < items.length; i++) {
      final product = await controller.getProductById(items[i].productId!);
      if (product != null) {
        products.add(product);
      }
    }
  }
}
