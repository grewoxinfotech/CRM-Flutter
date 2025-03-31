import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../care/secure_storage.dart';

class LeadService extends GetConnect {
  final String apiUrl = UrlResources.Leads;

  Future<List<LeadModel>> fetchLeads() async {
    try {

      String? token = await SecureStorage.getToken();

      if (token == null) {
        throw Exception("No token found. Please log in again.");
      }

      final response = await get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("API Response: ${response.body}"); // Debugging

        if (response.body is Map<String, dynamic>) {
          var jsonData = response.body;
          if (jsonData.containsKey("data") && jsonData["data"] is List) {
            List<dynamic> leadsList = jsonData["data"];
            return leadsList.map((lead) => LeadModel.fromJson(lead)).toList();
          } else {
            throw Exception("Unexpected API response format: Missing 'data' key or not a list");
          }
        } else {
          throw Exception("Unexpected API response format: Not a JSON object");
        }
      } else {
        throw Exception("Failed to load leads: ${response.statusText}");
      }
    } catch (e) {
      print("Error fetching leads: $e");
      throw Exception("Error fetching leads");
    }
  }
}
