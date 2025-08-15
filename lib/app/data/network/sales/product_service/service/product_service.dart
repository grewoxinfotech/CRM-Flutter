// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:crm_flutter/app/care/constants/url_res.dart';
// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
//
// import '../model/product_model.dart';
//
// class ProductService {
//   Future<List<Product>> getProducts() async {
//     try {
//       final clientId = await SecureStorage.getClientId();
//       if (clientId == null) throw Exception('Client ID not found');
//
//       final response = await http.get(
//         Uri.parse('${UrlRes.products}/$clientId'),
//         headers: await UrlRes.getHeaders(),
//       );
//
//       final data = jsonDecode(response.body);
//       if (response.statusCode == 200 && data['success'] == true) {
//         final List<dynamic> productsJson = data['data'];
//         return productsJson.map((json) => Product.fromJson(json)).toList();
//       }
//
//       throw Exception(data['message'] ?? 'Failed to fetch products');
//     } catch (e) {
//       throw Exception('Failed to fetch products: ${e.toString()}');
//     }
//   }
//
//   Future<Product> getProductById(String id) async {
//     try {
//       final clientId = await SecureStorage.getClientId();
//       if (clientId == null) throw Exception('Client ID not found');
//
//       final response = await http.get(
//         Uri.parse('${UrlRes.products}/$clientId/$id'),
//         headers: await UrlRes.getHeaders(),
//       );
//
//       final data = jsonDecode(response.body);
//       if (response.statusCode == 200 && data['success'] == true) {
//         return Product.fromJson(data['data']);
//       }
//
//       throw Exception(data['message'] ?? 'Failed to fetch product_service');
//     } catch (e) {
//       throw Exception('Failed to fetch product_service: ${e.toString()}');
//     }
//   }
//
//   Future<Product> createProduct(Map<String, dynamic> productData) async {
//     try {
//       final clientId = await SecureStorage.getClientId();
//       if (clientId == null) throw Exception('Client ID not found');
//
//       final response = await http.post(
//         Uri.parse('${UrlRes.products}/$clientId'),
//         headers: await UrlRes.getHeaders(),
//         body: jsonEncode(productData),
//       );
//
//       final data = jsonDecode(response.body);
//       if (response.statusCode == 201 && data['success'] == true) {
//         return Product.fromJson(data['data']);
//       }
//
//       throw Exception(data['message'] ?? 'Failed to create product_service');
//     } catch (e) {
//       throw Exception('Failed to create product_service: ${e.toString()}');
//     }
//   }
//
//   Future<Product> updateProduct(String id, Map<String, dynamic> productData) async {
//     try {
//       final clientId = await SecureStorage.getClientId();
//       if (clientId == null) throw Exception('Client ID not found');
//
//       final response = await http.put(
//         Uri.parse('${UrlRes.products}/$clientId/$id'),
//         headers: await UrlRes.getHeaders(),
//         body: jsonEncode(productData),
//       );
//
//       final data = jsonDecode(response.body);
//       if (response.statusCode == 200 && data['success'] == true) {
//         return Product.fromJson(data['data']);
//       }
//
//       throw Exception(data['message'] ?? 'Failed to update product_service');
//     } catch (e) {
//       throw Exception('Failed to update product_service: ${e.toString()}');
//     }
//   }
//
//   Future<bool> deleteProduct(String id) async {
//     try {
//       final clientId = await SecureStorage.getClientId();
//       if (clientId == null) throw Exception('Client ID not found');
//
//       final response = await http.delete(
//         Uri.parse('${UrlRes.products}/$clientId/$id'),
//         headers: await UrlRes.getHeaders(),
//       );
//
//       final data = jsonDecode(response.body);
//       if (response.statusCode == 200 && data['success'] == true) {
//         return true;
//       }
//
//       throw Exception(data['message'] ?? 'Failed to delete product_service');
//     } catch (e) {
//       throw Exception('Failed to delete product_service: ${e.toString()}');
//     }
//   }
// }

import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';
import '../../../super_admin/auth/model/user_model.dart';
import '../model/product_model.dart';

class ProductsServicesService {
  final String baseUrl = UrlRes.products;
  // UserModel? userData;
  // void getUser() async {
  //   userData = await SecureStorage.getUserData();
  // }

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<productsServicesModel?> fetchProductsServices({
    int page = 1,
    int pageSize = 10,
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
        print("[DEBUG]=> ${data}");
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
    // Get the current logged-in user's ID
    final userId = (await SecureStorage.getUserData())?.id;

    if (userId == null) {
      print("Error: No user ID found. Cannot create product.");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$userId"),
        headers: await headers(),
        body: jsonEncode(product.toJson()),
      );

      print("[DEBUG]=> $baseUrl ---- ${product.name} ----- $baseUrl/$userId");

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create product exception: ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateProduct(String id, Data product) async {
    try {
      final url = Uri.parse("$baseUrl$id");
      final response = await http.put(
        url,
        headers: await headers(),
        body: jsonEncode(product.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update product exception: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = Uri.parse("$baseUrl$id");
      final response = await http.delete(url, headers: await headers());
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete product exception: $e");
      return false;
    }
  }

  Future<Data?> getProductById(String id) async {
    try {
      print("[DEBUG]=> $baseUrl/$id");
      final url = Uri.parse("$baseUrl/$id");
      final response = await http.get(url, headers: await headers());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("[DEBUG]=> ${data}");
        return Data.fromJson(data["data"]);
      }
      return null;
    } catch (e) {
      print("Get product by ID exception: $e");
      return null;
    }
  }
}
