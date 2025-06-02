import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/auth/service/auth_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final obscurePassword = false.obs;
  final rememberMe = false.obs;
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() => obscurePassword.toggle();

  void fillTestCredentials() {  }

  Future<void> login(String userName, String password) async {
    if (!(formKey.currentState?.validate() ?? true)) return;

    if (!rememberMe.value) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Remember Me",
        message: "Please enable 'Remember Me' to continue.",
        contentType: ContentType.success,
      );
      return;
    }

    isLoading.value = true;
    try {
      await authService.login(password, userName);
    } finally {
      isLoading.value = false;
    }
  }
  void logout() => authService.logout();
}
