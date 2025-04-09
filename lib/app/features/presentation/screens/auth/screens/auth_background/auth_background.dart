import 'package:crm_flutter/app/features/presentation/widgets/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBackground extends StatelessWidget {
  final Widget? child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,

        title: CrmAppLogo(showTitle: true),
      ),
      body: child,
    );
  }
}
