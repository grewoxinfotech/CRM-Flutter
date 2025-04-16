import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/models/lead_model.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeadService extends GetConnect {
  getToken() async {
    String? token = await SecureStorage.getToken();
    if (token == null) throw Exception("No token found. Please log in again.");
    return token;
  }

  Future<List<LeadModel>> fetchLeads() async {
    try {
      final response = await http.get(
        Uri.parse(UrlRes.Leads),
        headers: {
          'Authorization': 'Bearer ${getToken()}',
          'Content-Type': 'application/json',
        },
      );

      final data = await jsonDecode(response.body);

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        if (data.containsKey("data") && data["data"] is List) {
          return (data["data"] as List)
              .map((e) => LeadModel.fromJson(e))
              .toList();
        }
        throw Exception("Invalid API response format");
      }
      throw Exception("Failed to load leads: ${data['message']}");
    } catch (e) {
      print("Error fetching leads: $e");
      throw Exception("Error fetching leads");
    }
  }

  Future<bool> deleteLead(String leadId) async {
    try {
      String? token = await SecureStorage.getToken();
      if (token == null)
        throw Exception("No token found. Please log in again.");

      final response = await http.delete(
        Uri.parse("${UrlRes.Leads}/$leadId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = await jsonDecode(response.body);

      if (response.statusCode == 200 && data['data'] is Map<String, dynamic>) {
        return data["success"] == true;
      } else {
        print("Delete failed: ${data['message']}");
        return false;
      }
    } catch (e) {
      print("Error deleting lead: $e");
      return false;
    }
  }
}
