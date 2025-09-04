import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../model/revenue_menu.dart';

class RevenueService {
  final String baseUrl = UrlRes.revenue; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch revenues with optional pagination & search
  Future<RevenueModel?> fetchRevenues({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return RevenueModel.fromJson(data);
      } else {
        print("Failed to load revenues: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchRevenues: $e");
    }
    return null;
  }
  // Future<List<RevenueData>> fetchRevenues({
  //     int page = 1,
  //     int pageSize = 10,
  //     String search = '',
  //   }) async {
  //     try {
  //       final uri = Uri.parse(baseUrl).replace(
  //         queryParameters: {
  //           'page': page.toString(),
  //           'pageSize': pageSize.toString(),
  //           'search': search,
  //         },
  //       );
  //
  //       final response = await http.get(uri, headers: await headers());
  //
  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         final List<dynamic> revenues = data["message"]["data"];
  //         return revenues.map((json) => RevenueData.fromJson(json)).toList();
  //       } else {
  //         print("Failed to load revenues: ${response.statusCode}");
  //       }
  //     } catch (e) {
  //       print("Exception in fetchRevenues: $e");
  //     }
  //     return [];
  //   }

  /// Get single revenue by ID
  Future<RevenueData?> getRevenueById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RevenueData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get revenue by ID exception: $e");
    }
    return null;
  }

  /// Create new revenue
  Future<bool> createRevenue(RevenueData revenue) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${revenue.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(revenue.toJson()),
      );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create revenue exception: $e");
      return false;
    }
  }

  /// Update revenue
  Future<bool> updateRevenue(String id, RevenueData revenue) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(revenue.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update revenue exception: $e");
      return false;
    }
  }

  /// Delete revenue
  Future<bool> deleteRevenue(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete revenue exception: $e");
      return false;
    }
  }
}
