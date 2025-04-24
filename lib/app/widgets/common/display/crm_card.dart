import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? shadowColor;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  const CrmCard({
    super.key,
    this.width,
    this.height,
    this.elevation,
    this.alignment,
    this.shadowColor,

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
      elevation: elevation ?? 5,
      shadowColor: shadowColor ?? Get.theme.colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(19),
      ),
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
