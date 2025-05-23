import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:http/http.dart' as http;

class LeadService {
  static final String url = UrlRes.lead;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all lead
  static Future<List<LeadModel>> getLeads() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Lead Service (data) : ${jsonData['data']}");
      return data.map((e) => LeadModel.fromJson(e)).toList();
    } else {
      print("Lead Service (error) : ${jsonData['message']}");
      print("Lead Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load lead data: ${response.statusCode}');
    }
  }

  /// 2. Get lead by ID
  Future<Map<String, dynamic>?> getLeadById(String id) async {
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

  /// 3. Create Lead
  Future<http.Response> createLead(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 4. Update Lead by ID
  Future<http.Response> updateLead(String id, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse("$url/$id"),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 5. Delete Lead by ID
  Future<bool> deleteLead(String id) async {
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
