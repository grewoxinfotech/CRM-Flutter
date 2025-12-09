import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/controllers/auth_controller.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/views/auth_background/auth_background.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../care/constants/string_res.dart';
import '../../../../../widgets/forget_password/view/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return AuthBackground(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Obx(() {
          return authController.isLoading.value
              ? const CrmLoadingCircle()
              : SingleChildScrollView(
                child: CrmCard(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In to ${StringRes.appName}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Get.theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: authController.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        child: Column(
                          children: [
                            CrmTextField(
                              title: "Email Address",
                              controller: authController.emailController,
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => CrmTextField(
                                title: "Password",
                                controller: authController.passwordController,
                                validator:
                                    (value) => passwordValidation(value ?? ''),
                                obscureText:
                                    authController.obscurePassword.value,
                                suffixIcon: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: CrmIc(
                                    iconPath: ICRes.viewPassword,
                                    onTap:
                                        authController.togglePasswordVisibility,
                                    height: 24,
                                    width: 24,
                                    color:
                                        authController.obscurePassword.value
                                            ? Get.theme.colorScheme.outline
                                            : Get.theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Checkbox(
                                  value: authController.rememberMe.value,
                                  onChanged:
                                      (value) =>
                                          authController.rememberMe.value =
                                              value ?? false,
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  checkColor: Get.theme.colorScheme.primary,
                                  activeColor: Colors.transparent,
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Get.theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ForgotPasswordScreen());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Get.theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                            side: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            checkColor: Get.theme.colorScheme.primary,
                            activeColor: Colors.transparent,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            _launchURL(
                                              'https://sites.google.com/view/privacy-policy-raisercrm/home',
                                            );
                                          },
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            _launchURL(
                                              'https://sites.google.com/view/terms-conditions-raisercrm/home',
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CrmButton(
                        title: "Login",
                        onTap:
                            isChecked
                                ? () => authController.login(
                                  authController.emailController.text.trim(),
                                  authController.passwordController.text.trim(),
                                )
                                : null,
                        backgroundColor: isChecked ? null : Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          print("Create account tapped");
                        },
                        child: Center(
                          child: Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
        }),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri);
  }
}
