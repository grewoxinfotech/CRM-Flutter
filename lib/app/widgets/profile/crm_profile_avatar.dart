import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmProfileAvatar extends StatelessWidget {
  final double? radius;
  final Widget? child;
  final ImageProvider? foregroundImage;
  final String? heroTag;

  const CrmProfileAvatar({
    super.key,
    this.foregroundImage,
    this.radius,
    this.child,
    this.heroTag,
  }); // Default radius set

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
          foregroundImage: foregroundImage,
          radius: radius ?? 20,
          child: child,
    );
    
    return GestureDetector(
      onTap: (){},
      child: heroTag != null
        ? Hero(
            tag: heroTag!,
            child: avatar,
          )
        : avatar,
    );
  }
}
