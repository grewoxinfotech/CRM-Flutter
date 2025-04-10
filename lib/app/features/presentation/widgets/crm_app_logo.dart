import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:flutter/material.dart';

class CrmAppLogo extends StatelessWidget {
  final double? width;
  final GestureTapCallback? onTap;

  const CrmAppLogo({super.key, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: "applogo",
        child: Image.asset(ICRes.appLogoPNG, width: width ?? 40),
      ),
    );
  }
}
