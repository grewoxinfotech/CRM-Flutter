import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const AuthElevatedButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(500, 50),
        backgroundColor: Get.theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
