import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomFormService extends GetxService {

  static final String url = UrlRes.customForms;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all Custom From
  static Future<List<CustomFormModel>> getCustomFrom() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Custom From Service (data) : ${jsonData['data']}");
      return data.map((e) => CustomFormModel.fromJson(e)).toList();
    } else {
      print("Custom From Service (error) : ${jsonData['message']}");
      print("Custom From Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load Custom From data: ${response.statusCode}');
    }
  }
}