import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmProfileAvatar extends StatelessWidget {
  final double? radius;
  final Widget? child;
  final ImageProvider? foregroundImage;

  const CrmProfileAvatar({
    super.key,
    this.foregroundImage,
    this.radius,
    this.child,
  }); // Default radius set

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profileAvtar",
      child: GestureDetector(
        onTap: (){},
        child: CircleAvatar(
          foregroundImage: foregroundImage,
          radius: radius ?? 20,
          child: child,
        ),
      ),
    );
  }
}
