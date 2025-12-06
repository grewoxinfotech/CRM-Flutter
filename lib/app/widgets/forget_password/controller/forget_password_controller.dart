
import 'dart:developer';

import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../data/database/storage/secure_storage_service.dart';
import '../../../data/network/forget_password_api/service/forget_password_service.dart';
import '../../../modules/super_admin/auth/views/login/login_screen.dart';
import '../view/widget/reset_password_screen.dart';
import '../view/widget/verify_otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Rxn<UserModel> user = Rxn<UserModel>();

  // Verification Code Controllers
  final List<TextEditingController> codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> codeFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  final formKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Resend timer
  final resendTimer = 29.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    // Dispose code controllers and focus nodes
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var focusNode in codeFocusNodes) {
      focusNode.dispose();
    }

    _timer?.cancel();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void sendResetInstructions() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();

      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final response = await ForgetPasswordService.instance.forgetPassword(
          email,
        );

        Get.back(); // Close loading dialog

        if (response.success) {
          Get.snackbar(
            "Success",
            response.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          await SecureStorage.saveToken(response.data?.sessionToken ?? '');
          final String token = await SecureStorage.getToken() ?? '';
          log("Toke asjdehw $token");

          Get.to(
            () => VerificationCodeScreen(
              email: email,
              // sessionToken: response.data?.sessionToken ?? '',
            ),
          );

          startResendTimer();
        } else {
          Get.snackbar(
            "Error",
            response.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.back(); // Close loader if any error
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("[FORGET PASSWORD CONTROLLER ERROR] $e");
      }
    }
  }

  void onCodeChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      // Move to next field
      codeFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field on backspace
      codeFocusNodes[index - 1].requestFocus();
    }
  }

  void verifyCode(String email) async {
    String code = codeControllers.map((c) => c.text).join().trim();

    if (code.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter the complete 6-digit code',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Call API
      final response = await ForgetPasswordService.instance.otpVerifyMethod(
        email,
        code,
      );

      Get.back(); // Close loading dialog

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // ✅ Navigate to Reset Password screen and pass session token if needed
        Get.to(
          () => ResetPasswordScreen(
            // email: email,
            // sessionToken: response.data?.sessionToken ?? '',
          ),
        );

        stopResendTimer();
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back(); // close loader if any error
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('[OTP VERIFY ERROR] $e');
    }
  }

  void startResendTimer() {
    resendTimer.value = 29;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void stopResendTimer() {
    _timer?.cancel();
    resendTimer.value = 0;
  }

  void resendCode() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is missing. Please go back and enter your email again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // 🔹 Reuse the same forget password API to resend OTP
      final response = await ForgetPasswordService.instance.forgetPassword(
        email,
      );

      Get.back(); // Close loader

      if (response.success) {
        Get.snackbar(
          'Success',
          'Verification code resent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await SecureStorage.saveToken(response.data?.sessionToken ?? '');

        final String token = await SecureStorage.getToken() ?? '';
        log("Toke resend $token");

        // Clear all OTP fields
        for (var controller in codeControllers) {
          controller.clear();
        }
        codeFocusNodes[0].requestFocus();

        startResendTimer();
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Something went wrong while resending the code. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('[RESEND CODE ERROR] $e');
    }
  }

  Future<void> resetPassword() async {
    if (resetFormKey.currentState!.validate()) {
      // Check if passwords match
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final data = await ForgetPasswordService.instance.resetPasswordMethod(
        newPasswordController.text,
        confirmPasswordController.text,
      );

      // Show success message
      if (data['success'] == true) {
        user.value = UserModel.fromJson(data['data']);
        Get.snackbar(
          'Success',
          'Password reset successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      Get.offAll(() => LoginScreen());
      // Clear fields
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }

  void clearFields() {
    emailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
