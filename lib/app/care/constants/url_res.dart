class UrlRes {
  static const String BASE_URL = "https://crm-api.grewox.com/api/v1";

  static const String AUTH = "$BASE_URL/auth";
  static const String LOGIN = "$AUTH/login";

  static const String Leads = "$BASE_URL/leads";
  static const String Lead_Add = "$BASE_URL/leads";

  static const String Deals = "$BASE_URL/deals";
  static const String Deal_Add = "$BASE_URL/deals";

  // const task api url
  static const String task = "${BASE_URL}/tasks";
  static const String taskAdd = "${BASE_URL}/task";
  static const String taskEdit = "${BASE_URL}/task";
  static const String taskDelete = "${BASE_URL}/task";
}
