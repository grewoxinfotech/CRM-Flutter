import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyService extends GetConnect {
  static final String url = UrlRes.companyAccounts;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all Company
  static Future<List<CompanyModel>> getCompany() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];

    if (response.statusCode == 200 && jsonData['success'] == true) {
      print("Company Service (data) : ${jsonData['data']}");
      return data.map((e) => CompanyModel.fromJson(e)).toList();
    } else {
      print("Company Service (error) : ${jsonData['message']}");
      print("Company Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load Company data: ${response.statusCode}');
    }
  }
}
