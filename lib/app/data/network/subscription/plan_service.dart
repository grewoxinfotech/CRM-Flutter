import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import '../../database/storage/secure_storage_service.dart';
import 'plan_model.dart';

class PlanService {
  final String baseUrl = UrlRes.subscriptions;

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch all available plans
  Future<List<PlanData>> fetchPlans() async {
    try {
      final uri = Uri.parse(baseUrl);
      print("Fetching plans from: $uri");

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Plans response: $data");

        try {
          final planModel = PlanModel.fromJson(data);
          print("Successfully parsed ${planModel.data?.length ?? 0} plans");
          return planModel.data ?? [];
        } catch (parseError, stackTrace) {
          print("Error parsing plans: $parseError");
          print("Stack trace: $stackTrace");
          print("Raw data: $data");
          throw parseError;
        }
      } else {
        print("Failed to load plans: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e, stackTrace) {
      print("Exception in fetchPlans: $e");
      print("Stack trace: $stackTrace");
    }
    return [];
  }

  /// Get single plan by ID
  Future<PlanData?> getPlanById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PlanData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get plan by ID exception: $e");
    }
    return null;
  }
}
