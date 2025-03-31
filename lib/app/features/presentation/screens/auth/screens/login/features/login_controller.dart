import 'dart:convert';

import 'package:crm_flutter/app/care/util//validators.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_snack_bar.dart';
import 'package:crm_flutter/app/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../care/secure_storage.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool rememberMe = false.obs;

  onscure() => obscurePassword.value = !obscurePassword.value;

  void login_button() async {
    print("press : Logint Button");
    UserModel user = UserModel(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    if (rememberMe == true) {
      var isformkey = formkey.currentState!.validate();
      if (isformkey == true) {
        Uri url = Uri.parse(UrlResources.LOGIN);
        try {
          var response = await http.post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"login": user.email, "password": user.password}),
          );

          print("Status Code: ${response.statusCode}");
          print("Response Body: ${response.body}");

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            if (data["success"]) {
              String token = data["data"]["token"];
              await SecureStorage.saveToken(token); // Save token securely

              print("Login Successful, Token: $token");
              Get.off(SignUpSuccessScreen());
            } else {
              crmSnackbar("Login Failed", data["message"], isError: true);
            }
          } else {
            print("Server Error: ${response.statusCode}, Response: ${response.body}");
          }
        } catch (e) {
          print("Error: $e");
        }
      } else {
        crmSnackbar("Error", "Email and Password not Found!", isError: true);
      }
    }
  }
}
