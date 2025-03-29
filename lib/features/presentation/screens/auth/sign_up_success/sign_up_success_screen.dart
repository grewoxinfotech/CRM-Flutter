import 'package:crm_flutter/features/presentation/screens/auth/widgets/auth_elevated_button.dart';
import 'package:crm_flutter/features/presentation/screens/home/home_screen.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CrmAppLogo(showTitle: true),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CrmContainer(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset("assets/images/Illustration (1).png", width: 300),
                  const SizedBox(height: 100),
                  const Text(
                    'You are successfully registered!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  AuthElevatedButton(
                    title: "Let's Start",
                    onPressed: () => Get.offAll(HomeScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
