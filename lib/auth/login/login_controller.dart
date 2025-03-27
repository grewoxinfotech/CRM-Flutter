
import 'dart:convert';

import 'package:crm_flutter/auth/login/login_model.dart';
import 'package:crm_flutter/auth/sign_up_success/sign_up_success_screen.dart';
import 'package:crm_flutter/care/uitl/validators.dart';
import 'package:crm_flutter/features/data/resources/url_resources.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
              // CrmSnackbar("Login SucsessFul", "${response.statusCode}", false);
              String token = data["data"]["token"];
              SharedPreferences profile = await SharedPreferences.getInstance();
              profile.setString("token", token.toString());
              profile.setBool("islogin", true);
              print("Login Successful, Token: $token");
              Get.off(SignUpSuccessScreen());
            } else {
              crmSnackbar("Login Failed", "${data["message"]}", isError: true);
              print("Login Failed: ${data["message"]}");
            }
          } else {
            print(
              "Server Error: ${response.statusCode}, Response: ${response.body}",
            );
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
