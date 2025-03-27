import 'package:flutter/material.dart';

class CrmIndicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare; // Nullable hataya, default value de di
  final double size;
  final Color? textColor;

  const CrmIndicator({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = false, // Default value set
    this.size = 16,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(backgroundColor: color, radius: 10),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
