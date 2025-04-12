import 'package:crm_flutter/app/modules/auth/views/auth_background/auth_background.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SingleChildScrollView(
        child: CrmCard(
          width: 600,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: CrmImg(
                  imagePath: "assets/images/Illustration.svg",
                  width: 300,
                ),
              ),
              const SizedBox(height: 100),
              const Text(
                'You are successfully registered!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              CrmButton(
                title: "Let's Start",
                onTap: () => Get.offAll(DashboardScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
