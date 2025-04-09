import 'package:crm_flutter/app/features/presentation/screens/auth/screens/auth_background/auth_background.dart';
import 'package:crm_flutter/app/features/presentation/screens/dashboard/dashboard.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SingleChildScrollView(
        child: CrmContainer(
          width: 600,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: SvgPicture.asset(
                  "assets/images/Illustration.svg",
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
                onPressed: () => Get.offAll(Dashboard()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
