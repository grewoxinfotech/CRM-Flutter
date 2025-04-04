import 'dart:convert';
import 'package:crm_flutter/app/care/secure_storage.dart';
import 'package:crm_flutter/app/care/util//validators.dart';
import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool rememberMe = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  onscure() => obscurePassword.value = !obscurePassword.value;

  void login_button() async {
    print("Press: Login Button");

    String emailText = email.text.trim();
    String passwordText = password.text.trim();


    if (emailText.isEmpty || passwordText.isEmpty) {
     // crmSnackbar("Error", "Email and Password are required!", isError: true);
      emailText = "grewox1001@yopmail.com";
      passwordText =  "MyStrongP@ssw0rd!";
    }

    print("Final Payload:");
    print(jsonEncode({
      "login": emailText,
      "password": passwordText,
    }));



    try {
      var response = await http.post(
        Uri.parse(UrlResources.LOGIN),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "login": emailText,
          "password": passwordText
        }),
      );

      // print("Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["success"]) {
          String token = data["data"]["token"];
          await SecureStorage.saveToken(token);
          print("Login Successful, Token: $token");
          Get.off(SignUpSuccessScreen());
        } else {
          crmSnackbar("Login Failed", data["message"], isError: true);
        }
      } else {
        crmSnackbar("Error", "Invalid login credentials!", isError: true);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}
