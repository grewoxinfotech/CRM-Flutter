import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../../care/constants/color_res.dart';

import '../../../../modules/super_admin/auth/views/login/login_screen.dart';
import '../../controller/forget_password_controller.dart';

class VerificationCodeScreen extends StatelessWidget {
  String email = '';
  VerificationCodeScreen({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: ColorRes.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () {
                    controller.stopResendTimer();
                    Get.offAll(() => LoginScreen());
                  },
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
                const SizedBox(height: 60),

                // Title
                Center(
                  child: Text(
                    'Enter Verification Code',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: ColorRes.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'We\'ve sent a 6-digit code to your email address. Enter the code below to verify.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorRes.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 6-Digit Code Input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: _CodeInputBox(
                        controller: controller.codeControllers[index],
                        focusNode: controller.codeFocusNodes[index],
                        onChanged: (value) {
                          controller.onCodeChanged(value, index);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Verify Code Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.verifyCode(email);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorRes.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Verify Code',
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Didn't receive code
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Didn\'t receive the code?',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorRes.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        if (controller.resendTimer.value > 0) {
                          return Text(
                            'Resend in ${controller.resendTimer.value}s',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorRes.textSecondary.withOpacity(0.7),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: controller.resendCode,
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorRes.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
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

class _CodeInputBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const _CodeInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust the divisor depending on how many boxes you have (e.g., 6 OTP boxes)
    final boxWidth = screenWidth / 10; // gives a balanced size for 6–8 boxes

    return Container(
      width: boxWidth.clamp(40.0, 70.0), // limit min/max for responsiveness
      height: 55,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorRes.textSecondary.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorRes.textPrimary,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
      ),
    );
  }
}
