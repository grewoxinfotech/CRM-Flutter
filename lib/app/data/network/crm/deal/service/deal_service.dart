import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../model/deal_model.dart';

class DealService {
  final String baseUrl = UrlRes.deals; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch deals with optional pagination & search
  Future<DealModel?> fetchDeals({
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
        print("Deals: $data");
        return DealModel.fromJson(data);
      } else {
        print("Failed to load deals: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchDeals: $e");
    }
    return null;
  }

  /// Get single deal by ID
  Future<DealData?> getDealById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DealData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get deal by ID exception: $e");
    }
    return null;
  }

  Future<DealData?> createDeal(DealData data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: await headers(),
      body: jsonEncode(data),
    );

    print("=> response = ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return DealData.fromJson(json); // ✅ Parse and return created deal
    }
    return null;
  }

  /// Update deal by ID
  Future<bool> updateDeal(String id, DealData deal) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(deal.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Deal updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update deal",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update deal exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the deal",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete deal by ID
  Future<bool> deleteDeal(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      final responseData = jsonDecode(response.body);

      CrmSnackBar.showAwesomeSnackbar(
        title: "Message",
        message:
            responseData['message'] is String
                ? responseData['message']
                : "Operation completed",
        contentType: ContentType.success,
      );

      return responseData['success'] ?? false;
    } catch (e) {
      print("Delete deal exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while deleting the deal",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
