import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:get/get.dart';

class CompanyService extends GetConnect {
  static final String url = UrlRes.companyAccounts;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all Company
  static getCompany() async {}
}
