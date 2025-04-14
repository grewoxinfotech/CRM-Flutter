import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;


class AuthController extends GetxController {
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final username = ''.obs;
  final token = ''.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() => obscurePassword.toggle();

  void fillTestCredentials() {
    emailController.text = "grewox1001@yopmail.com";
    passwordController.text = "MyStrongP@ssw0rd!";
  }

  Future<void> login() async {
    final context = Get.context!;

    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!rememberMe.value) {
      CrmSnackBar.showAwesomeSnackbar(
        context: context,
        title: "Remember Me",
        message: "Please enable 'Remember Me' to continue.",
        contentType: ContentType.help,
      );
      return;
    }

    final loginData = {
      "login": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse(UrlRes.LOGIN),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginData),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        final fetchedToken = data["data"]["token"];
        final fetchedUsername =
            data["data"]["user"]["username"] ?? loginData["login"];

        await SecureStorage.saveToken(fetchedToken);
        await SecureStorage.saveUsername(fetchedUsername);
        await SecureStorage.saveRememberMe(true);
        await SecureStorage.saveLoggedIn(true);

        token(fetchedToken);
        username(fetchedUsername);
        isLoggedIn(true);

        Get.offAll(() => DashboardScreen());

        CrmSnackBar.showAwesomeSnackbar(
          context: context,
          title: "Welcome!",
          message: "Login successful!",
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          context: context,
          title: "Login Failed",
          message: data["message"] ?? "Unknown error",
          contentType: ContentType.warning,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        context: context,
        title: "Error",
        message: "Something went wrong: $e",
        contentType: ContentType.failure,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    isLoading(true);
    await SecureStorage.clearAll();
    token('');
    username('');
    isLoggedIn(false);
    Get.offAllNamed('/login');
    isLoading(false);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
