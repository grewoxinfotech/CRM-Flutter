import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/models/deal_model.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DealService extends GetConnect {
  Future<List<DealModel>> fetchDeals() async {
    String? token = await SecureStorage.getToken();
    if (token == null) throw Exception("No token found. Please log in again.");

    try {
      final response = await http.get(
        Uri.parse(UrlRes.Deals),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data is Map<String, dynamic>) {
        if (data.containsKey("data") && data["data"] is List) {
          return (data["data"] as List)
              .map((e) => DealModel.fromJson(e))
              .toList();
        }
        throw Exception("Invalid API response format");
      }
      throw Exception("Failed to load deals: ${data['message']}");
    } catch (e) {
      throw Exception("Error fetching deals");
    }
  }

  Future<bool> deleteDeal(String id) async {
    try {
      String? token = await SecureStorage.getToken();

      final response = await http.delete(
        Uri.parse("${UrlRes.Deals}/$id"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final data = await jsonDecode(response.body);

      if (response.statusCode == 200 && data is Map<String, dynamic>) {
        return data["success"] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
