import 'package:crm_flutter/app/care/constants/size/border_res.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmCard extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  const CrmCard({
    super.key,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 600,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Get.theme.colorScheme.surface,
        borderRadius: borderRadius ?? BorderRes.borderR1,
        border: border,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Get.theme.colorScheme.shadow.withAlpha(20),
                blurRadius: 20,
                offset: Offset(0, 6),
              ),
            ],
      ),
      child: child,
    );
  }
}
