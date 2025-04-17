import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeadService extends GetConnect {
  final url = UrlRes.leads;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> getLeads() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final data = jsonDecode(response.body);
    return (response.statusCode == 200) ? data['data'] ?? [] : [];
  }

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
