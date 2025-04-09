import 'package:crm_flutter/app/care/secure_storage.dart';
import 'package:crm_flutter/app/features/data/deal/deal_model.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:get/get.dart';

class DealService extends GetConnect {
  final String apiUrl = UrlResources.Deals;

  Future<List<DealModel>> fetchDeals() async {
    try {
      String? token = await SecureStorage.getToken();
      if (token == null) throw Exception("No token found. Please log in again.");

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
              .map((deal) => DealModel.fromJson(deal))
              .toList();
        }
        throw Exception("Invalid API response format");
      }

      throw Exception("Failed to load deals: ${response.statusText}");
    } catch (e) {
      print("Error fetching deals: $e");
      throw Exception("Error fetching deals");
    }
  }

  Future<bool> deleteDeal(String dealId) async {
    try {
      String? token = await SecureStorage.getToken();
      if (token == null) throw Exception("No token found. Please log in again.");

      final response = await delete(
        "$apiUrl/$dealId",
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
      print("Error deleting deal: $e");
      return false;
    }
  }
}
