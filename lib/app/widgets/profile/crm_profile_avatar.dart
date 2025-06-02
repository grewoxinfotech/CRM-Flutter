import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmProfileAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? image;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final String heroTag;
  final BoxShadow? shadow;

  const CrmProfileAvatar({
    super.key,
    this.radius = 20,
    this.image,
    this.child,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.heroTag = "profileAvatar",
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? Get.theme.colorScheme.background,
            border:
                borderColor != null
                    ? Border.all(color: borderColor!, width: borderWidth)
                    : null,
            boxShadow: shadow != null ? [shadow!] : null,
            image:
                image != null
                    ? DecorationImage(image: image!, fit: BoxFit.cover)
                    : null,
          ),
          child: image == null ? Center(child: child) : null,
        ),
      ),
    );
  }
}
