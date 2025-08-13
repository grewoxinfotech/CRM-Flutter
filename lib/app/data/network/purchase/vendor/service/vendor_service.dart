import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';
import '../model/vendor_model.dart';

class VendorService {
  final String baseUrl = UrlRes.vendors;

  // Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  // Fetch vendors with optional pagination and search
  Future<Message?> fetchVendors({
    int page = 1,
    int pageSize = 10,
    String search = '',
    String id = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(queryParameters: {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'search': search,
        'id': id,
      });

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return Message.fromJson(data['message']);
        }
      } else {
        print("Failed to fetch vendors: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchVendors: $e");
    }
    return null;
  }

  // Get all vendors
  Future<List<VendorData>> getAllVendors() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> vendorsJson = data['message']['data'];
        return vendorsJson.map((json) => VendorData.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load vendors: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception in getAllVendors: $e");
    }
  }

  // Create a new vendor
  Future<bool> createVendor(VendorData vendor) async {
    try {
      final userId = (await SecureStorage.getUserData())?.id;
      if (userId == null) return false;

      final response = await http.post(
        Uri.parse("$baseUrl/$userId"),
        headers: await headers(),
        body: jsonEncode(vendor.toJson()),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create vendor exception: $e");
      return false;
    }
  }

  // Update an existing vendor
  Future<bool> updateVendor(String id, VendorData vendor) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(vendor.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update vendor exception: $e");
      return false;
    }
  }

  // Delete a vendor
  Future<bool> deleteVendor(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete vendor exception: $e");
      return false;
    }
  }
}
