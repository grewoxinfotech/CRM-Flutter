import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/product/model/product_model.dart';
import 'package:crm_flutter/app/data/network/product/service/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final fetchedProducts = await _productService.getProducts();
      products.value = fetchedProducts;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      error.value = '';
      return await _productService.getProductById(id);
    } catch (e) {
      error.value = e.toString();
      return null;
    }
  }

  Future<Product?> createProduct(Map<String, dynamic> productData) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final newProduct = await _productService.createProduct(productData);
      products.add(newProduct);
      return newProduct;
    } catch (e) {
      error.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Product?> updateProduct(String id, Map<String, dynamic> productData) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final updatedProduct = await _productService.updateProduct(id, productData);
      final index = products.indexWhere((product) => product.id == id);
      if (index != -1) {
        products[index] = updatedProduct;
      }
      return updatedProduct;
    } catch (e) {
      error.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final success = await _productService.deleteProduct(id);
      if (success) {
        products.removeWhere((product) => product.id == id);
      }
      return success;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
} 