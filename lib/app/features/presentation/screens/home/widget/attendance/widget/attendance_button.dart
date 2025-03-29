import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const AttendanceButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 0),
        padding: EdgeInsets.zero,
        backgroundColor: Get.theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
