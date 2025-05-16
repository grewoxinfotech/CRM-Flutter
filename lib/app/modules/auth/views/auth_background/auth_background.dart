import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBackground extends StatelessWidget {
  final Widget? child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CrmAppLogo(),
            const SizedBox(width: 10),
            Text(
              "Grewox",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
