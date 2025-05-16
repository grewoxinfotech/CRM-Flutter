import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:http/http.dart' as http;

class DealService {
  final String url = UrlRes.deals;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all deal
  Future<List> getDeals() async {
    try {
      final response = await http.get(Uri.parse(url), headers: await headers());
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["success"] == true) {
        return data['data'] ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  /// 2. Get deal by ID
  Future<Map<String, dynamic>?> getDealById(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return null;
    }
  }

  /// 3. Create Deal
  Future<http.Response> createDeal(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 4. Update Deal by ID
  Future<http.Response> updateDeal(String id, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse("$url/$id"),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 5. Delete Deal by ID
  Future<bool> deleteDeal(String id) async {
    final response = await http.delete(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    final data = jsonDecode(response.body);
    CrmSnackBar.showAwesomeSnackbar(
      title: "Message",
      message: data['message'],
      contentType: ContentType.success,
    );
    return data['success'];
  }
}
