import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadService extends GetConnect {
  final String apiUrl = UrlResources.Leads; // Replace with your API endpoint

  Future<List<LeadModel>> fetchLeads() async {
    try {
      SharedPreferences profile = await SharedPreferences.getInstance();
      String? token = profile.getString("tokan");

      token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImdyZXdveDEwMDEiLCJlbWFpbCI6ImdyZXdveDEwMDFAeW9wbWFpbC5jb20iLCJwaG9uZSI6bnVsbCwiaWQiOiJkMnV5a3hiVkNXNWwyMWxKWHVPNmpFTyIsInJvbGUiOiJ6bXVneWZ4T2V6MENCZTNhZU96bWRMRSIsInJvbGVOYW1lIjoiY2xpZW50IiwiY3JlYXRlZF9ieSI6InN1cGVyYWRtaW4iLCJpYXQiOjE3NDMyNDg1MzksImV4cCI6MTc0MzMzNDkzOX0.r1ucIhwkICdcHCne9MwWz40WQlbMj1Oi_HzzqduflKA";

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
