import 'package:flutter/material.dart';

class CrmCard extends StatelessWidget {
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
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
    return Container(
      width: width ?? 600,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        border: border,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withAlpha(
                  50,
                ), // Optimized for better performance
                blurRadius: 56,
                offset: Offset(0, 6),
              ),
            ],
      ),
      child: child,
    );
  }
}
