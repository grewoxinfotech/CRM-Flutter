

import 'package:crm_flutter/app/data/service/storage/secure_storage_service.dart';

class UrlRes {
  static const String baseURL = "https://crm-api.grewox.com/api/v1";

  static const String auth = "$baseURL/auth";

  static const String login = "$auth/login";

  static const String leads = "$baseURL/leads";

  static const String deals = "$baseURL/deals";

  static const String task = "$baseURL/tasks";

  // headers from api
  static const String contentType = "Content-type";
  static const String applicationJson = "application/json";

  // headers for auth
  static const String authorization = "Authorization";

  static Future<Map<String, String>> getHeaders() async {
    final token = await SecureStorage.getToken();
    return {contentType: applicationJson, authorization: "Bearer $token"};
  }
}
