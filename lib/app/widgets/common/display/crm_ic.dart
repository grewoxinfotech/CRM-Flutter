import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmIc extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final double size;
  final Color? color;

  const CrmIc({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Obx(() => Icon(icon, size: size, color: color));

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque, // Better tap area
        child: iconWidget,
      );
    } else {
      return iconWidget;
    }
  }
}
