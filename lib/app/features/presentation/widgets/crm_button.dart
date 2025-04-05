import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? titleTextColor;



  CrmButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.backgroundColor,
    this.borderRadius,
    this.titleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? 150, height ?? 48),
        backgroundColor: backgroundColor ?? Get.theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: borderRadius ??  BorderRadius.circular(10)),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize ?? 16,fontWeight: FontWeight.w700, color: titleTextColor ?? Colors.white),
      ),
    );
  }
}
