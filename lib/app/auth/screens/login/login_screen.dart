import 'package:crm_flutter/app/auth/screens/login/features/login_controller.dart';
import 'package:crm_flutter/app/auth/widgets/auth_elevated_button.dart';
import 'package:crm_flutter/app/auth/widgets/auth_text_form_field.dart';
import 'package:crm_flutter/app/care/util/validators.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CrmAppLogo(showTitle: true),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Get.theme.colorScheme.background,
      body: SingleChildScrollView(
        child: CrmContainer(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Sign In to Grewox',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 20),

              Obx(
                () => Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        title: "Email Address",
                        controller: controller.email,
                        // validator: (email)=> email_validation(email!),
                      ),
                      const SizedBox(height: 25),

                      AuthTextFormField(
                        title: "Password",
                        controller: controller.password,
                       // validator: (password) => password_validation(password!),
                        obscureText:
                            (controller.obscurePassword.value) ? true : false,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.onscure(),
                          child: FittedBox(
                            child: Row(
                              children: [
                                Image.asset(
                                  ICRes.appLogo,
                                  color:
                                      (controller.obscurePassword.value)
                                          ? Get.theme.colorScheme.outline
                                          : Get.theme.colorScheme.primary,
                                  width: 50,
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value = value!;
                          },
                        ),
                      ),
                      const Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      controller.email.text;
                      controller.password.text;
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AuthElevatedButton(
                title: "Sign in",
                onPressed: () => controller.login_button(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
