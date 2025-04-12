import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/service/auth_service.dart';
import 'package:crm_flutter/app/modules/auth/views/sign_up_success/sign_up_success_screen.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString username = "".obs;
  RxString token = "".obs;
  bool _autoLoginCalled = false;

  @override
  void onInit() {
    if (!_autoLoginCalled) {
      autoLogin();
      _autoLoginCalled = true;
    }
    super.onInit();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool rememberMe = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void onscure() => obscurePassword.value = !obscurePassword.value;

  void forgotPassword() {
    email.text = "grewox1001@yopmail.com";
    password.text = "MyStrongP@ssw0rd!";
  }

  void login_button(String email, String password) async {
    var isformkey = formkey.currentState!;
    if (isformkey != true) {
      isLoading(true);
      try {
        var response = await http.post(
          Uri.parse(UrlRes.LOGIN),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"login": email, "password": password}),
        );

        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data["success"]) {
          String fetchedToken = data["data"]["token"];
          String fetchedUsername = data["data"]["user"]["username"] ?? email;

          if (rememberMe.value) {
            await SecureStorage.saveToken(fetchedToken);
            await SecureStorage.saveUsername(fetchedUsername);
            await SecureStorage.saveRememberMe(true);
          } else {
            await SecureStorage.clearAll(); // Don't remember anything
          }

          token(fetchedToken);
          username(fetchedUsername);
          isLoggedIn(true);

          Get.offAll(() => SignUpSuccessScreen());
        } else {
          crmSnackbar("Login Failed", data["message"], isError: true);
        }
        isLoading(false);
      } catch (e) {
        crmSnackbar("Error", "Something went wrong: $e", isError: true);
        isLoading(false);
      }
      isLoading(false);
    }
    isLoading(false);
  }

  void autoLogin() async {
    isLoading(true);
    bool shouldRemember = await SecureStorage.getRememberMe();
    if (!shouldRemember) return;
    String? savedToken = await SecureStorage.getToken();
    String? savedUsername = await SecureStorage.getUsername();

    if (savedToken != null) {
      token(savedToken);
      username(savedUsername ?? "");
      isLoggedIn(true);
      Get.offAll(() => SignUpSuccessScreen());
      isLoading(false);
    }
    isLoading(false);
  }

  void logout() async {
    isLoading(true);
    await SecureStorage.clearAll();
    token("");
    username("");
    isLoggedIn(false);
    Get.offAllNamed('/login');
    isLoading(false);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    isLoading(false);
    obscurePassword(true);
    rememberMe(false);
    email.dispose();
    password.dispose();
    super.onClose();
  }
}