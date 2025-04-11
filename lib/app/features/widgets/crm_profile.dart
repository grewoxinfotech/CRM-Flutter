import 'package:crm_flutter/app/features/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GestureDetector(
      onTap: ()=> Get.to(ProfileScreen()),
      child: Hero(
        tag: "profile_logo",
        child: CircleAvatar(
          foregroundImage: foregroundImage,
          radius: radius ?? 20,
          child: child,
        ),
      ),
    );
  }
}
