import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmCard extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final DecorationImage? image;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Widget? child;

  const CrmCard({
    Key? key,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.image,
    this.boxShadow,
    this.border,
    this.child,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: width,
        height: height,
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          image: image,
          borderRadius: borderRadius ?? BorderRadius.circular(30),
          border: border,
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 56,
                  spreadRadius: 0,
                  offset: Offset(0, 6),
                ),
              ],
        ),
        child: child,
      ),
    );
  }
}
