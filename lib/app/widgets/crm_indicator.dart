import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmIndicator extends StatelessWidget {
  final Color color;
  final String text;
  final TextStyle? textStyle;
  final double radius;
  final double spacing;

  const CrmIndicator({
    super.key,
    required this.color,
    required this.text,
    this.textStyle,
    this.radius = 10,
    this.spacing = 8, // Assuming AppSpacing.horizontalSmall is 8.0
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: Get.theme.colorScheme.onPrimary,
    );

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ?? defaultTextStyle,
        ),
      ],
    );
  }
}
