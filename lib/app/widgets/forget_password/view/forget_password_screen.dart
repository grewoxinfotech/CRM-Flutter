import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../care/constants/color_res.dart';
import '../../../care/utils/validation.dart';
import '../../common/inputs/crm_text_field.dart';
import '../controller/forget_password_controller.dart';
//import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: ColorRes.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
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
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: ColorRes.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Center(
                  child: Text(
                    'Enter your email address and we\'ll send you instructions to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorRes.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Email Input Form
                Form(
                  key: controller.formKey,
                  child: CrmTextField(
                    title: "Email",
                    controller: controller.emailController,
                    validator: (value) => emailValidation(value ?? ''),
                    prefixIcon: Icons.mail_outline,
                  ),
                ),
                const SizedBox(height: 20),

                // Send Reset Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.sendResetInstructions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorRes.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Send Reset Instructions',
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
