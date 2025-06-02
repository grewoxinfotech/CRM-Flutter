import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactService extends GetConnect {
  static final String url = UrlRes.contacts;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  static Future<List> getContacts() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Contact Service (data) : ${jsonData['data']}");
      return data.map((e) => ContactModel.fromJson(e)).toList();
    } else {
      print("Contact Service (error) : ${jsonData['message']}");
      print("Contact Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load Contact data: ${response.statusCode}');
    }
  }
}
