import 'package:flutter/material.dart';

class CrmIc extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? icon;
  final double? size;
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
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: size, color: color ?? Colors.black,
      weight: 10,),
    );
  }
}
