

import 'dart:convert';
import 'dart:io';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';
import '../../../super_admin/auth/model/user_model.dart';
import '../model/product_model.dart';

class ProductsServicesService {
  final String baseUrl = UrlRes.products;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<productsServicesModel?> fetchProductsServices({
    int page = 1,
    int pageSize = 50,
    String search = '',
    String id = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
          'id': id,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("=> ${data}");
        return productsServicesModel.fromJson(data);
      } else {
        print("Failed to load products: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception in fetchProductsServices: $e");
      return null;
    }
  }

  Future<List<Data?>> getProducts() async {
    try {
      final uri = Uri.parse(baseUrl);

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("=> ${data}");
        final List<dynamic> products = await data["message"]["data"];
        return products.map((product) => Data.fromJson(product)).toList();
      } else {
        throw Exception("Failed to load all products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception in fetchAllProductsServices: $e");
    }
  }

  Future<bool> createProduct(Data product) async {
    final userId = (await SecureStorage.getUserData())?.id;

    if (userId == null) {
      print("Error: No user ID found. Cannot create product.");
      return false;
    }

    try {
      final url = Uri.parse("$baseUrl/$userId");
      final request = http.MultipartRequest('POST', url);

      final reqHeaders = await headers();
      reqHeaders.remove('Content-Type');
      request.headers.addAll(reqHeaders);

      // Add fields
      request.fields.addAll({
        'name': product.name ?? '',
        'category': product.category ?? '',
        'buying_price': (product.buyingPrice ?? 0).toString(),
        'selling_price': (product.sellingPrice ?? 0).toString(),
        'currency': product.currency ?? '',
        'sku': product.sku ?? '',
        'tax_name': product.taxName ?? '',
        'tax_percentage': (product.taxPercentage ?? 0).toString(),
        'hsn_sac': product.hsnSac ?? '',
        'description': product.description ?? '',
        'stock_quantity': (product.stockQuantity ?? 0).toString(),
        'min_stock_level': (product.minStockLevel ?? 0).toString(),
        'max_stock_level': (product.maxStockLevel ?? 0).toString(),
        'reorder_quantity': (product.reorderQuantity ?? 0).toString(),
        'stock_status': product.stockStatus ?? '',
        'created_by': userId,
      });

      // Add image if available
      if (product.image != null && product.image!.isNotEmpty) {
        final imageFile = File(product.image!);
        if (await imageFile.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('image', imageFile.path),
          );
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("=> Response: ${response.statusCode} - ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Create product exception: $e");
      return false;
    }
  }

  Future<bool> updateProduct(String id, Data product) async {
    try {
      print("=> product id $id");
      print("=> product url $baseUrl/$id");

      final url = Uri.parse("$baseUrl/$id");
      final request = http.MultipartRequest('PUT', url);

      // Add headers (excluding Content-Type, as multipart handles it automatically)
      final reqHeaders = await headers();
      reqHeaders.remove('Content-Type');
      request.headers.addAll(reqHeaders);

      // Add fields (all product fields except image)
      request.fields['name'] = product.name ?? '';
      request.fields['category'] = product.category ?? '';
      request.fields['buying_price'] = (product.buyingPrice ?? 0).toString();
      request.fields['selling_price'] = (product.sellingPrice ?? 0).toString();
      request.fields['currency'] = product.currency ?? '';
      request.fields['sku'] = product.sku ?? '';
      request.fields['tax_name'] = product.taxName ?? '';
      request.fields['tax_percentage'] =
          (product.taxPercentage ?? 0).toString();
      request.fields['hsn_sac'] = product.hsnSac ?? '';
      request.fields['description'] = product.description ?? '';
      request.fields['stock_quantity'] =
          (product.stockQuantity ?? 0).toString();
      request.fields['min_stock_level'] =
          (product.minStockLevel ?? 0).toString();
      request.fields['max_stock_level'] =
          (product.maxStockLevel ?? 0).toString();
      request.fields['reorder_quantity'] =
          (product.reorderQuantity ?? 0).toString();
      request.fields['stock_status'] = product.stockStatus ?? '';
      request.fields['updated_by'] = product.createdBy ?? '';

      // // Add image only if provided
      if (product.image != null && product.image!.isNotEmpty) {
        final imageFile = File(product.image!);
        if (await imageFile.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath('image', imageFile.path),
          );
        }
      }

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // print("=> update response code: ${response.statusCode}");
      // print("=> update response body: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Update product exception: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = Uri.parse("$baseUrl/$id");
      final response = await http.delete(url, headers: await headers());
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete product exception: $e");
      return false;
    }
  }

  Future<Data?> getProductById(String id) async {
    try {
      final url = Uri.parse("$baseUrl/$id");
      final response = await http.get(url, headers: await headers());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Data.fromJson(data["data"]);
      }
      return null;
    } catch (e) {
      print("Get product by ID exception: $e");
      return null;
    }
  }
}
