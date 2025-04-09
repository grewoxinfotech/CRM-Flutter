import 'dart:convert';
import 'package:crm_flutter/app/care/secure_storage.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  RxBool isloding = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString username = "".obs;
  RxString token = "".obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool rememberMe = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    autoLogin();
    super.onInit();
  }

  void onscure() => obscurePassword.value = !obscurePassword.value;

  void forgotPassword() {
    email.text = "grewox1001@yopmail.com";
    password.text = "MyStrongP@ssw0rd!";
  }

  void login_button(String email, String password) async {
    try {
      isloding.value = true;
      var response = await http.post(
        Uri.parse(UrlResources.LOGIN),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"login": email, "password": password}),
      );
      isloding.value = false;

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

        token.value = fetchedToken;
        username.value = fetchedUsername;
        isLoggedIn.value = true;

        Get.offAll(() => SignUpSuccessScreen());
      } else {
        crmSnackbar("Login Failed", data["message"], isError: true);
      }
    } catch (e) {
      isloding.value = false;
      crmSnackbar("Error", "Something went wrong: $e", isError: true);
    }
  }

  void autoLogin() async {
    bool shouldRemember = await SecureStorage.getRememberMe();
    if (!shouldRemember) return;

    String? savedToken = await SecureStorage.getToken();
    String? savedUsername = await SecureStorage.getUsername();

    if (savedToken != null) {
      token.value = savedToken;
      username.value = savedUsername ?? "";
      isLoggedIn.value = true;
      Get.offAll(() => SignUpSuccessScreen());
    }
  }

  void logout() async {
    await SecureStorage.clearAll();
    token.value = "";
    username.value = "";
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
