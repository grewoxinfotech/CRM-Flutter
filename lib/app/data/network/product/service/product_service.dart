import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/product/model/product_model.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    try {
      final clientId = await SecureStorage.getClientId();
      if (clientId == null) throw Exception('Client ID not found');
      
      final response = await http.get(
        Uri.parse('${UrlRes.products}/$clientId'),
        headers: await UrlRes.getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        final List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      }
      
      throw Exception(data['message'] ?? 'Failed to fetch products');
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final clientId = await SecureStorage.getClientId();
      if (clientId == null) throw Exception('Client ID not found');
      
      final response = await http.get(
        Uri.parse('${UrlRes.products}/$clientId/$id'),
        headers: await UrlRes.getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return Product.fromJson(data['data']);
      }
      
      throw Exception(data['message'] ?? 'Failed to fetch product');
    } catch (e) {
      throw Exception('Failed to fetch product: ${e.toString()}');
    }
  }

  Future<Product> createProduct(Map<String, dynamic> productData) async {
    try {
      final clientId = await SecureStorage.getClientId();
      if (clientId == null) throw Exception('Client ID not found');
      
      final response = await http.post(
        Uri.parse('${UrlRes.products}/$clientId'),
        headers: await UrlRes.getHeaders(),
        body: jsonEncode(productData),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 201 && data['success'] == true) {
        return Product.fromJson(data['data']);
      }
      
      throw Exception(data['message'] ?? 'Failed to create product');
    } catch (e) {
      throw Exception('Failed to create product: ${e.toString()}');
    }
  }

  Future<Product> updateProduct(String id, Map<String, dynamic> productData) async {
    try {
      final clientId = await SecureStorage.getClientId();
      if (clientId == null) throw Exception('Client ID not found');
      
      final response = await http.put(
        Uri.parse('${UrlRes.products}/$clientId/$id'),
        headers: await UrlRes.getHeaders(),
        body: jsonEncode(productData),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return Product.fromJson(data['data']);
      }
      
      throw Exception(data['message'] ?? 'Failed to update product');
    } catch (e) {
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final clientId = await SecureStorage.getClientId();
      if (clientId == null) throw Exception('Client ID not found');
      
      final response = await http.delete(
        Uri.parse('${UrlRes.products}/$clientId/$id'),
        headers: await UrlRes.getHeaders(),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      }
      
      throw Exception(data['message'] ?? 'Failed to delete product');
    } catch (e) {
      throw Exception('Failed to delete product: ${e.toString()}');
    }
  }
} 