
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class UrlRes {
  static const String baseURL = "https://api.raiser.in/api/v1";

  static const String auth = "$baseURL/auth";

  static const String login = "$auth/login";

  static const String leads = "$baseURL/lead";
  
  static const String pipelines = "$baseURL/pipelines";

  static const String stages = "$baseURL/stages";

  static const String deals = "$baseURL/deal";

  static const String task = "$baseURL/tasks";

  static const String roles = "$baseURL/roles";

  

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
