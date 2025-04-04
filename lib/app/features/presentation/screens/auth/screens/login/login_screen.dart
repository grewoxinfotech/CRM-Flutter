import 'package:crm_flutter/app/care/util/validators.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/login/features/login_controller.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_form_field.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: CrmAppLogo(showTitle: true, width: 60),
      ),
      body: SingleChildScrollView(
        child: CrmContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      CrmFormField(
                        title: "Email Address",
                        controller: controller.email,
                        // validator: (email)=> email_validation(email!),
                      ),
                      const SizedBox(height: 20),
                      CrmFormField(
                        title: "Password",
                        controller: controller.password,
                        validator: (password) => passwordValidation(password!),
                        obscureText:
                            (controller.obscurePassword.value) ? true : false,
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
                          onChanged: (value) => controller.rememberMe.value = value!,
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          focusColor: Colors.green,
                          checkColor: Get.theme.colorScheme.primary,
                          activeColor: Colors.transparent,

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
              CrmButton(
                title: "Sign in",
                width: 500,
                onPressed: () => controller.login_button(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
