import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/crm/crm_system/label/controller/label_controller.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';

class ProductsServicesController extends PaginatedController<Data> {
  final ProductsServicesService _service = ProductsServicesService();
  late final LabelController labelController;

  final String url = UrlRes.products;

  var isLoading = false.obs;

  //dropdown
  final selectedCategory = Rxn<String>();

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
    // Initialize LabelController first to avoid late initialization error
    try {
      labelController =
          Get.isRegistered<LabelController>()
              ? Get.find<LabelController>()
              : Get.put(LabelController());
    } catch (_) {
      labelController = Get.put(LabelController());
    }

    loadInitial();
  }

  Future<void> refreshProducts() async {
    try {
      isLoading.value = true;
      final fetchedItems = await fetchItems(1);
      items.assignAll(fetchedItems);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  // --- CRUD METHODS ---

  Future<bool> createProduct(Data product) async {
    try {
      isLoading.value = true;

      final success = await _service.createProduct(product);
      if (success) {
        await refreshProducts();
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to create product service",
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProduct(String id, Data updatedProduct) async {
    try {
      final success = await _service.updateProduct(id, updatedProduct);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedProduct;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to update product service",
        contentType: ContentType.failure,
      );
      print("Update product_service error: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final success = await _service.deleteProduct(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      return false;
    }
  }


//test 
  // Get category options from labels
  List<Map<String, String>> get categoryOptions {
    try {
      //   if (labelController == null) return [];
      final categories = labelController.getCategories();
      print('[DEBUG]=> categories: $categories');
      return categories
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (e) {
      return [];
    }
  }
}
