import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;

  CrmButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.titleTextStyle,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        width: width ?? 150,
        height: height ?? 48,
        color: backgroundColor ?? Get.theme.colorScheme.primary,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        boxShadow: boxShadow,
        child: Text(
          title,
          style:
              titleTextStyle ??
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.surface,
              ),
        ),
      ),
    );
  }
}
