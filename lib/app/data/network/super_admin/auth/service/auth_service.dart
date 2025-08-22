import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetConnect {
  final String url = UrlRes.login;
  final String i = UrlRes.contentType;
  final String j = UrlRes.applicationJson;

  Future<void> login(String email, String password) async {
    final loginData = {"login": email, "password": password};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {i: j},
        body: jsonEncode(loginData),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["success"] == true) {
        final token = data['data']['token'];
        final user = UserModel.fromJson(data['data']['user']);
        await SecureStorage.saveToken(token);
        await SecureStorage.saveUserData(user);
        await SecureStorage.saveRememberMe(true);
        await SecureStorage.saveLoggedIn(true);

        Get.offAll(DashboardScreen());

        CrmSnackBar.showAwesomeSnackbar(
          title: "Welcome!",
          message: "Login successful!",
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Login Failed",
          message: data["message"] ?? "Unknown error",
          contentType: ContentType.warning,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong: $e",
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> logout() async {
    await SecureStorage.clearAll();
    Get.offAll(LoginScreen());
  }
}
