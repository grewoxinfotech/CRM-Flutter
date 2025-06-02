import 'package:flutter/material.dart';

class CrmAppLogo extends StatelessWidget {
  final double width;
  final GestureTapCallback? onTap;

  const CrmAppLogo({
    super.key,
    this.width = 40,  // default width set directly here
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "appLogo",
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          "assets/images/app_logo.png",
          width: width,
          fit: BoxFit.contain, // ensure aspect ratio is maintained
        ),
      ),
    );
  }
}
