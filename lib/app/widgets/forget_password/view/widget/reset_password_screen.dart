import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/color_res.dart';
import '../../../../care/constants/ic_res.dart';
import '../../../../care/utils/validation.dart';
import '../../../../modules/super_admin/auth/views/login/login_screen.dart';
import '../../../common/display/crm_ic.dart';
import '../../../common/inputs/crm_text_field.dart';
import '../../controller/forget_password_controller.dart';
//import '../controller/forgot_password_controller.dart';*/

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: ColorRes.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Get.offAll(() => LoginScreen()),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: ColorRes.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Lock Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ColorRes.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    color: ColorRes.primary,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Center(
                child: Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: ColorRes.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Center(
                child: Text(
                  'Enter your new password below',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: ColorRes.textSecondary),
                ),
              ),
              const SizedBox(height: 32),

              // Password Input Form
              Form(
                key: controller.resetFormKey,
                child: Column(
                  children: [
                    Obx(
                      () => CrmTextField(
                        title: "Password",
                        controller: controller.newPasswordController,
                        validator: newPasswordValidation,
                        obscureText: !controller.isNewPasswordVisible.value,
                        suffixIcon: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: CrmIc(
                            iconPath: ICRes.viewPassword,
                            onTap: controller.toggleNewPasswordVisibility,
                            height: 24,
                            width: 24,
                            color:
                                !controller.isNewPasswordVisible.value
                                    ? Get.theme.colorScheme.outline
                                    : Get.theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => CrmTextField(
                        title: "Confirm Password",
                        controller: controller.confirmPasswordController,
                        validator:
                            (value) => confirmPasswordValidation(
                              value,
                              controller.newPasswordController.text,
                            ),
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        suffixIcon: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: CrmIc(
                            iconPath: ICRes.viewPassword,
                            onTap: controller.toggleConfirmPasswordVisibility,
                            height: 24,
                            width: 24,
                            color:
                                !controller.isConfirmPasswordVisible.value
                                    ? Get.theme.colorScheme.outline
                                    : Get.theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Reset Password Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorRes.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Remember Password Link
              Center(
                child: Column(
                  children: [
                    Text(
                      'Remember your password?',
                      style: TextStyle(
                        color: ColorRes.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login
                        Get.offAll(() => LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ColorRes.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
