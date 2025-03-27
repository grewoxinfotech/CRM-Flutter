import 'package:flutter/material.dart';

class CrmProfile extends StatelessWidget {
  final double? radius;
  final Widget? child;
  final ImageProvider? foregroundImage;

  const CrmProfile({
    super.key,
    this.foregroundImage,
    this.radius,
    this.child,
  }); // Default radius set

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile_logo",
      child: CircleAvatar(
        foregroundImage: foregroundImage,
        radius: radius ?? 20,
        child: child,
      ),
    );
  }
}
