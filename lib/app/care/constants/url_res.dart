import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';

class UrlRes {
  static const String baseURL = "https://api.raiser.in/api/v1";

  static const String auth = "$baseURL/auth";

  static const String login = "$auth/login";

  static const String leads = "$baseURL/leads";

  static const String pipelines = "$baseURL/pipelines";

  static const String stages = "$baseURL/stages";

  static const String deals = "$baseURL/deals";

  static const String task = "$baseURL/tasks";

  static const String roles = "$baseURL/roles";

  static const String labels = "$baseURL/labels";

  static const String allUsers = "$baseURL/auth";

  static const String notes = "$baseURL/notes";

  static const String leadsFiles = "$baseURL/leads/files";

  static const String dealsFiles = "$baseURL/deals/files";

  static const String activities = "$baseURL/activities";

  static const String salesInvoices = "$baseURL/sales-invoices";

  static const String products = "$baseURL/products";

  static const String customers = "$baseURL/customers";

  static const String companies = "$baseURL/company-accounts";

  static const String contacts = "$baseURL/contacts";

  static const String currencies = "$baseURL/currencies";

  static const String creditNotes = "$baseURL/sales-creditnote";

  static const String employees = "$baseURL/employees";

  /// HRM
  static const String branches = "$baseURL/branches";

  static const String designations = "$baseURL/designations";

  static const String departments = "$baseURL/departments";

  static const String holidays = "$baseURL/holidays";

  static const String leaves = "$baseURL/leaves";

  //puchase
  static const String revenue = "$baseURL/sales-revenue";

  static const String billing = "$baseURL/bills";

  //vendor
  static const String vendors = "$baseURL/vendors";

  static const String debitnotes = "$baseURL/bill-debits";

  static const String verifySignup = "$baseURL/verify-signup";

  //sales_functionality-APIs
  // static const String sales = "$baseURL/products";
  // static const String addsales = "$baseURL/products/$getClientId()";

  // headers from api
  static const String contentType = "Content-type";
  static const String applicationJson = "application/json";

  // headers for auth
  static const String authorization = "Authorization";

  static Future<Map<String, String>> getHeaders() async {
    final token = await SecureStorage.getToken();
    return {contentType: applicationJson, authorization: "Bearer $token"};
  }

  // static Future<String?> getClientId() async {
  //   return await SecureStorage.getClientId();
  // }
}
