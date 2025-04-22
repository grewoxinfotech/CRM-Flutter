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
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Get.theme.colorScheme.surface,
      margin: margin ?? EdgeInsets.zero,
      elevation: 5,
      shadowColor: Get.theme.colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: width ?? 600,
        height: height,
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
