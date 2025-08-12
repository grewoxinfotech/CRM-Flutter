import 'dart:convert';

import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';

class ProductsServicesController extends PaginatedController<Data> {
  final ProductsServicesService _service = ProductsServicesService();

  final String url = UrlRes.products;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<Data>> fetchItems(int page) async {
    final response = await _service.fetchProductsServices(page: page);
    if (response != null && response.success == true) {
      totalPages.value = response.message?.pagination?.totalPages ?? 1;
      return response.message?.data ?? [];
    } else {
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  // --- CRUD METHODS ---

  Future<bool> createProduct(Data product) async {
    try {
      final success = await _service.createProduct(product);
      print("Create product_service success: $product");
      if (success) {
        return success;
      } else {
        return false;
      }
    } catch (e) {
      print("Create product_service error: $e");
      return false;
    }
  }
  //  Future<bool> createProduct(Data product) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: await headers(),
  //       body: jsonEncode(product.toJson()),
  //     );
  //
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return true;
  //     } else {
  //       print('Create product_service failed. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Exception creating product_service: $e');
  //     return false;
  //   }
  // }

  Future<bool> updateProduct(String id, Data updatedProduct) async {
    try {
      final success = await _service.updateProduct(id, updatedProduct);
      if (success) {
        // Optionally update product_service in local items list
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedProduct;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update product_service error: $e");
      return false;
    }
  }

//test
  Future<bool> deleteProduct(String id) async {
    try {
      final success = await _service.deleteProduct(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete product_service error: $e");
      return false;
    }
  }
}
