import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/auth/auth_controller.dart';
import 'package:crm_flutter/app/features/screens/auth/auth_background/auth_background.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/widgets/crm_loading_circle.dart';
import 'package:crm_flutter/app/features/widgets/crm_text_field.dart';
import 'package:crm_flutter/app/services/validation_service.dart';
import 'package:crm_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return AuthBackground(
      child: Obx(() {
        return controller.isLoading.value != true
            ? CrmLoadingCircle()
            : SingleChildScrollView(
              child: CrmCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Sign In to Grewox',
                      style: TextStyle(
                        fontSize: 20,
                        color: COLORRes.TEXT_PRIMARY,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: controller.formkey,
                      child: Column(
                        children: [
                          CrmTextField(
                            title: "Email Address",
                            controller: controller.email,
                            validator: (email) => emailValidation(email!),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                                ()=> CrmTextField(
                              title: "Password",
                              controller: controller.password,
                              validator:
                                  (password) => passwordValidation(password!),
                              obscureText:
                              (controller.obscurePassword.value)
                                  ? true
                                  : false,
                              suffixIcon: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: CrmIcon(
                                  iconPath: ICRes.viewPassword,
                                  onTap: () => controller.onscure(),
                                  height: 24,
                                  width: 24,
                                  color:
                                  (controller.obscurePassword.value)
                                      ? Get.theme.colorScheme.outline
                                      : Get.theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: controller.rememberMe.value,
                                onChanged:
                                    (value) =>
                                        controller.rememberMe.value = value!,
                                side: BorderSide(color: Colors.black, width: 2),
                                focusColor: Colors.green,
                                checkColor: Get.theme.colorScheme.primary,
                                activeColor: Colors.transparent,
                              ),
                            ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 14,
                                color: COLORRes.TEXT_PRIMARY,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => controller.forgotPassword(),
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
                    const SizedBox(height: 30),
                    CrmButton(
                      title: "Sign in",
                      onTap:
                          () => controller.login_button(
                            controller.email.text,
                            controller.password.text,
                          ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        print("Create account Link");
                      },
                      child: Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
      }),
    );
  }
}
