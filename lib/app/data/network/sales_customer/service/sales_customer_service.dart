import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/data/network/sales_customer/model/sales_customer_model.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';


class SalesCustomerService {
  final String baseUrl = UrlRes.customers;

  Future<List<SalesCustomer>> getSalesCustomers() async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => SalesCustomer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load customers: $e');
    }
  }

  Future<SalesCustomer> getSalesCustomer(String id) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return SalesCustomer.fromJson(data);
      } else {
        throw Exception('Failed to load customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load customer: $e');
    }
  }

  Future<SalesCustomer> createSalesCustomer(Map<String, dynamic> data) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body)['data'];
        return SalesCustomer.fromJson(responseData);
      } else {
        throw Exception('Failed to create customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }

  Future<SalesCustomer> updateSalesCustomer(String id, Map<String, dynamic> data) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        return SalesCustomer.fromJson(responseData);
      } else {
        throw Exception('Failed to update customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update customer: $e');
    }
  }

  Future<bool> deleteSalesCustomer(String id) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete customer: $e');
    }
  }
} 