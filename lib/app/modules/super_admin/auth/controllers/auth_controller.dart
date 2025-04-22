import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/service/auth/auth_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final username = ''.obs;
  final token = ''.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() => obscurePassword.toggle();

  void fillTestCredentials() {
    emailController.text = "grewox1001@yopmail.com";
    passwordController.text = "MyStrongP@ssw0rd!";
  }

  Future<void> login(String userName, String password) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!rememberMe.value) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Remember Me",
        message: "Please enable 'Remember Me' to continue.",
        contentType: ContentType.help,
      );
      return;
    }

    isLoading.value = true;
    try {
      await authService.login(userName, password);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() => authService.logout();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
