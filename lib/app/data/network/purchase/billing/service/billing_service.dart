import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;
import '../model/billing_model.dart';

class BillingService {
  final String baseUrl = UrlRes.billing; // <-- Define in UrlRes

  // Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch bills with optional pagination, search, and filtering by ID
  Future<BillingModel?> fetchBills({
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
        if (data['success'] == true) {
          return BillingModel.fromJson(data);
        }
      } else {
        print("Failed to fetch bills: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchBills: $e");
    }
    return null;
  }

  /// Get all bills (no pagination)
  Future<List<BillingData>> getAllBills() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> billsJson = data['message']['data'];
        return billsJson.map((json) => BillingData.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load bills: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception in getAllBills: $e");
    }
  }

  /// Create a new bill
  Future<bool> createBill(BillingData bill, String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$userId"),
        headers: await headers(),
        body: jsonEncode(bill.toJson()),
      );
      // print("[DEBUG]=> $baseUrl/IPoucZkvAMQ0BX1owqj5jxK ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create bill exception: $e");
      return false;
    }
  }

  /// Update an existing bill
  Future<bool> updateBill(String id, BillingData bill) async {
    try {
      print("[DEBUG]=> $baseUrl/$id ---- ${bill.toJson()}");
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(bill.toJson()),
      );

      print("[DEBUG]=> $baseUrl/$id ---- ${response.body}");
      print("[DEBUG]=> $baseUrl/$id ---- ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("Update bill exception: $e");
      return false;
    }
  }

  /// Delete a bill
  Future<bool> deleteBill(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete bill exception: $e");
      return false;
    }
  }
}
