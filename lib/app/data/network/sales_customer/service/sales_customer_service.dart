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
        final responseData = json.decode(response.body);
        
        if (responseData['success'] == true) {
          List<dynamic> customersData = [];
          
          // Handle different response structures
          if (responseData['data'] != null) {
            // Direct data format
            customersData = responseData['data'];
          } else if (responseData['message'] != null && responseData['message'] is Map && responseData['message']['data'] != null) {
            // If data is nested under message
            customersData = responseData['message']['data'];
          }
          
          return customersData.map((json) => SalesCustomer.fromJson(json)).toList();
        } else {
          throw Exception('API returned success: false');
        }
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
        final responseData = json.decode(response.body);
        
        if (responseData['success'] == true) {
          Map<String, dynamic>? customerData;
          
          // Handle different response structures
          if (responseData['data'] != null) {
            // Direct data format
            customerData = responseData['data'];
          } else if (responseData['message'] != null && responseData['message'] is Map && responseData['message']['data'] != null) {
            // If data is nested under message
            customerData = responseData['message']['data'];
          }
          
          if (customerData != null) {
            return SalesCustomer.fromJson(customerData);
          } else {
            throw Exception('Customer data not found in response');
          }
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to load customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load customer: $e');
    }
  }

  Future<bool> createSalesCustomer(Map<String, dynamic> data) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['success'] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSalesCustomer(String id, Map<String, dynamic> data) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['success'] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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