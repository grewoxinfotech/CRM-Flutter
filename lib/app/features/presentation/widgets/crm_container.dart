import 'package:flutter/material.dart';

class CrmContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  const CrmContainer({
    super.key,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.child, // Child ko optional rakha
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(
                  0.1,
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
