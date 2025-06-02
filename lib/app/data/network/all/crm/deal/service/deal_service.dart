import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:http/http.dart' as http;

class DealService {
  static final String url = UrlRes.deal;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all deals
  static Future<List> getDeals() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Deal Service (data) : ${jsonData['data']}");
      return data.map((e) => DealModel.fromJson(e)).toList();
    } else {
      print("Deal Service (error) : ${jsonData['message']}");
      print("Deal Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load Deal data: ${response.statusCode}');
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
