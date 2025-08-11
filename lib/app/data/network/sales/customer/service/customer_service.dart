import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';

class CustomerService {
  final String baseUrl = "${UrlRes.customers}";

  // Common headers
  Future<Map<String, String>> headers() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // If you store token in SecureStorage:
      'Authorization': 'Bearer ${await SecureStorage.getToken()}',
    };
  }

  /// Get all customers
  Future<List<CustomerData>> getCustomers() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> customerList = data["message"]["data"];
        return customerList.map((json) => CustomerData.fromJson(json)).toList();
      }
    } catch (e) {
      print("Get customers exception: $e");
    }
    return [];
  }

  /// Get single customer by ID
  Future<CustomerData?> getCustomerById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CustomerData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get customer by ID exception: $e");
    }
    return null;
  }

  /// Create new customer
  Future<bool> createCustomer(CustomerData customer) async {
    final userId = (await SecureStorage.getUserData())?.id;
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$userId"),
        headers: await headers(),
        body: jsonEncode(customer.toJson()),
      );

      print("[DEBUG]=> Create Customer: $customer");
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

      print("[DEBUG]=> Update Customer: $customer");
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
      return response.statusCode == 200;
    } catch (e) {
      print("Delete customer exception: $e");
      return false;
    }
  }
}
