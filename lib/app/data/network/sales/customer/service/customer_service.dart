import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';

class CustomerService {
  final String baseUrl = UrlRes.customers;

  // Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch customers with optional pagination & search
  Future<CustomerModel?> fetchCustomers({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("=> $baseUrl ---- ${response.body}");
        // final List<dynamic> customers = data["message"]["data"];
        // print("=> $baseUrl ---- ${customers.length}");
        return CustomerModel.fromJson(data);
        // return customers.map((json) => CustomerData.fromJson(json)).toList();
      } else {
        print("Failed to load customers: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchCustomers: $e");
    }
    return null;
  }

  /// Get single customer by I
  Future<CustomerData?> getCustomerById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      print("=> $baseUrl/$id ---- ${response.body}");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['data'] != null) {
          return CustomerData.fromJson(json['data']);
        }
      }
    } catch (e) {
      print("Get customer by ID exception: $e");
    }
    return null;
  }

  /// Create new customer
  Future<bool> createCustomer(CustomerData customer) async {
    final userId = (await SecureStorage.getUserData())?.id;
    if (userId == null) {
      print("Error: No user ID found. Cannot create customer.");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl"),
        headers: await headers(),
        body: jsonEncode(customer.toJson()),
      );

      print("=> $baseUrl/$userId ---- ${customer.name}");
      print("=> $baseUrl/$userId ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create customer exception: $e");
      return false;
    }
  }

  /// Update customer
  Future<bool> updateCustomer(String id, CustomerData customer) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(customer.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update customer exception: $e");
      return false;
    }
  }

  /// Delete customer

  Future<bool> deleteCustomer(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete customer exception: $e");
      return false;
    }
  }
}
