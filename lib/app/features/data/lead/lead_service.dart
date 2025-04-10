import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/resources/url_resources.dart';
import 'package:crm_flutter/app/services/secure_storage_service.dart';
import 'package:get/get.dart';

class LeadService extends GetConnect {
  final String apiUrl = UrlRes.Leads;

  Future<List<LeadModel>> fetchLeads() async {
    try {
      final String? token = await SecureStorage.getToken();
      if (token == null)
        throw Exception("No token found. Please log in again.");

      final response = await get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        var jsonData = response.body;
        if (jsonData.containsKey("data") && jsonData["data"] is List) {
          return (jsonData["data"] as List)
              .map((lead) => LeadModel.fromJson(lead))
              .toList();
        }
        throw Exception("Invalid API response format");
      }

      throw Exception("Failed to load leads: ${response.statusText}");
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

      final response = await delete(
        "$apiUrl/$leadId",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        return response.body["success"] == true;
      } else {
        print("Delete failed: ${response.statusText}");
        return false;
      }
    } catch (e) {
      print("Error deleting lead: $e");
      return false;
    }
  }
}
