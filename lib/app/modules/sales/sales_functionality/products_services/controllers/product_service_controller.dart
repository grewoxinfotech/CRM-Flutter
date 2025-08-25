import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/crm/crm_system/label/controller/label_controller.dart';
import '../../../../../data/network/sales/product_service/model/product_model.dart';
import '../../../../../data/network/sales/product_service/service/product_service.dart';
//
// class ProductsServicesController extends PaginatedController<Data> {
//   final ProductsServicesService _service = ProductsServicesService();
//   late final LabelController labelController;
//
//   final String url = UrlRes.products;
//
//   var isLoading = false.obs;
//
//   //dropdown
//   final selectedCategory = Rxn<String>();
//
//   static Future<Map<String, String>> headers() async {
//     return await UrlRes.getHeaders();
//   }
//
//   @override
//   Future<List<Data>> fetchItems(int page) async {
//     final response = await _service.fetchProductsServices(page: page);
//     if (response != null && response.success == true) {
//       totalPages.value = response.message?.pagination?.totalPages ?? 1;
//       return response.message?.data ?? [];
//     } else {
//       return [];
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize LabelController first to avoid late initialization error
//     try {
//       labelController =
//           Get.isRegistered<LabelController>()
//               ? Get.find<LabelController>()
//               : Get.put(LabelController());
//     } catch (_) {
//       labelController = Get.put(LabelController());
//     }
//
//     loadInitial();
//   }
//
//   Future<void> refreshProducts() async {
//     try {
//       isLoading.value = true;
//       final fetchedItems = await fetchItems(1);
//       items.assignAll(fetchedItems);
//     } catch (e) {
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // --- CRUD METHODS ---
//
//   Future<bool> createProduct(Data product) async {
//     try {
//       isLoading.value = true;
//
//       final success = await _service.createProduct(product);
//       if (success) {
//         await refreshProducts();
//       }
//       return success;
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "Failed to create product service",
//         contentType: ContentType.failure,
//       );
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<bool> updateProduct(String id, Data updatedProduct) async {
//     try {
//       final success = await _service.updateProduct(id, updatedProduct);
//       if (success) {
//         int index = items.indexWhere((item) => item.id == id);
//         if (index != -1) {
//           items[index] = updatedProduct;
//           items.refresh();
//         }
//       }
//       return success;
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "Failed to update product service",
//         contentType: ContentType.failure,
//       );
//       print("Update product_service error: $e");
//       return false;
//     }
//   }
//
//   Future<bool> deleteProduct(String id) async {
//     try {
//       final success = await _service.deleteProduct(id);
//       if (success) {
//         items.removeWhere((item) => item.id == id);
//       }
//       return success;
//     } catch (e) {
//       return false;
//     }
//   }
//
//
// //test
//   // Get category options from labels
//   List<Map<String, String>> get categoryOptions {
//     try {
//       //   if (labelController == null) return [];
//       final categories = labelController.getCategories();
//       print('[DEBUG]=> categories: $categories');
//       return categories
//           .map((label) => {'id': label.id, 'name': label.name})
//           .toList();
//     } catch (e) {
//       return [];
//     }
//   }
// }

class ProductsServicesController extends PaginatedController<Data> {
  final ProductsServicesService _service = ProductsServicesService();
  late final LabelController labelController;

  final String url = UrlRes.products;
  var isLoading = false.obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final skuController = TextEditingController();
  final descriptionController = TextEditingController();
  final taxNameController = TextEditingController();
  final taxPercentageController = TextEditingController();
  final hsnSacController = TextEditingController();
  final stockQuantityController = TextEditingController(text: '0');
  final minStockLevelController = TextEditingController(text: '0');
  final maxStockLevelController = TextEditingController(text: '0');
  final reorderQuantityController = TextEditingController(text: '0');

  // Dropdown values
  final currencies = [
    {'code': 'q6xe5PwPo74hw2hkumFyBvb', 'symbol': '₹', 'name': 'INR'},
  ];
  final stockStatuses = ['in_stock', 'low_stock', 'out_of_stock'];
  String? selectedCategoryId;
  String? selectedCurrencyCode;
  String? selectedStockStatus;

  // Image
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

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

    // Defaults
    selectedCategoryId =
        categoryOptions.isNotEmpty ? categoryOptions.first['id'] : null;
    selectedCurrencyCode = currencies.first['code'];
    selectedStockStatus = stockStatuses.first;

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

  // Future<Data> getProductById(String productId) async {
  //   try {
  //     isLoading.value = true;
  //     final existingProduct = items.firstWhereOrNull((item) => item.id == productId);
  //     if (existingProduct != null) {
  //       return existingProduct;
  //     }
  //     final response = await _service.getProductById(productId);
  //     if (response != null) {
  //       return response;
  //     } else {
  //       return Data();
  //     }
  //   } catch (e) {
  //     return Data();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  Future<void> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (image != null) {
      selectedImage = image;
      update();
    }
  }

  void removeImage() {
    selectedImage = null;
    update();
  }

  bool validateStockLevels() {
    final stockQty = int.tryParse(stockQuantityController.text.trim());
    final minStock = int.tryParse(minStockLevelController.text.trim());
    final maxStock = int.tryParse(maxStockLevelController.text.trim());
    final reorderQty = int.tryParse(reorderQuantityController.text.trim());

    if ([stockQty, minStock, maxStock, reorderQty].contains(null)) {
      _showError("Stock values must be valid numbers.");
      return false;
    }
    if ([stockQty!, minStock!, maxStock!, reorderQty!].any((v) => v < 0)) {
      _showError("Stock values cannot be negative.");
      return false;
    }
    if (minStock > maxStock) {
      _showError(
        "Minimum Stock Level cannot be greater than Maximum Stock Level.",
      );
      return false;
    }
    if (stockQty > maxStock) {
      _showError("Stock Quantity cannot be greater than Maximum Stock Level.");
      return false;
    }
    if (reorderQty > maxStock) {
      _showError(
        "Reorder Quantity cannot be greater than Maximum Stock Level.",
      );
      return false;
    }
    return true;
  }

  void _showError(String message) {
    CrmSnackBar.showAwesomeSnackbar(
      title: "Error",
      message: message,
      contentType: ContentType.failure,
    );
  }

  Future<void> submitProduct() async {
    if (!formKey.currentState!.validate()) return;
    if (!validateStockLevels()) return;

    isLoading.value = true;

    final product = Data(
      name: nameController.text.trim(),
      category: selectedCategoryId ?? '',
      buyingPrice: int.tryParse(buyingPriceController.text) ?? 0,
      sellingPrice: int.tryParse(sellingPriceController.text) ?? 0,
      currency: selectedCurrencyCode ?? '',
      sku: skuController.text.trim(),
      taxName: taxNameController.text.trim(),
      taxPercentage: int.tryParse(taxPercentageController.text) ?? 0,
      hsnSac: hsnSacController.text.trim(),
      description: descriptionController.text.trim(),
      stockQuantity: int.tryParse(stockQuantityController.text) ?? 0,
      minStockLevel: int.tryParse(minStockLevelController.text) ?? 0,
      maxStockLevel: int.tryParse(maxStockLevelController.text) ?? 0,
      reorderQuantity: int.tryParse(reorderQuantityController.text) ?? 0,
      stockStatus: selectedStockStatus ?? '',
      createdBy: 'grewox',
      image: selectedImage?.path,
    );

    final success = await createProduct(product);
    isLoading.value = false;

    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Product added successfully"
              : "Failed to add product service",
      contentType: success ? ContentType.success : ContentType.failure,
    );

    if (success) Get.back();
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

  Future<Data?> getProductById(String id) async {
    try {
      await refreshProducts();
      final exists = items.any((item) => item.id == id);
      print("[DEBUG]=> Exists: ${items.length}");
      print(
        "[DEBUG]=> Exists: ${items.map((element) => element.id).join(", ")}",
      );
      if (exists) {
        print("[DEBUG]=> Item exists");
        return items.firstWhere((item) => item.id == id);
      }
      final response = await _service.getProductById(id);
      print("[DEBUG]=> ${response?.toJson()}");
      if (response != null) {
        return response;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Category options
  List<Map<String, String>> get categoryOptions {
    try {
      final categories = labelController.getCategories();
      return categories
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (_) {
      return [];
    }
  }
}
