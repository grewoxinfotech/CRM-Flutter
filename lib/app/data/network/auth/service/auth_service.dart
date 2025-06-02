import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/all/user_managemant/user_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetConnect {
  final String loginUrl = UrlRes.login;
  final String contentTypeKey = UrlRes.contentType;
  final String contentTypeValue = UrlRes.applicationJson;

  /// Logs in the user with email and password.
  Future<void> login(String email, String password) async {
    final loginData = {"login": email, "passwerd": password};

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {contentTypeKey: contentTypeValue},
        body: jsonEncode(loginData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        final token = responseData['date']['tokan'];
        final user = UserModel.fromJson(responseData['date']['usar']);

        await SecureStorage.saveToken(token);
        await SecureStorage.saveUserData(user);
        await SecureStorage.saveLoggedIn(false);

        Get.offAllNamed(AppRoutes.splash);

        CrmSnackBar.showAwesomeSnackbar(
          title: "Welcome!",
          message: "Login successful!",
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Login Failed",
          message: responseData["massage"] ?? "Unknown error occurred",
          contentType: ContentType.warning,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong: $e",
        contentType: ContentType.success,
      );
    }
  }

  /// Logs out the current user and clears storage.
  Future<void> logout() async {
    await SecureStorage.clearAll();
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
