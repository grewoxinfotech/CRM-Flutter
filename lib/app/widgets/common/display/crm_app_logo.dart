import 'package:crm_flutter/app/care/constants/img_res.dart';
import 'package:flutter/material.dart';

class CrmAppLogo extends StatelessWidget {
  final double? width;
  final GestureTapCallback? onTap;

  const CrmAppLogo({super.key, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "appLogo",
      child: GestureDetector(
        onTap: onTap,
      ),
    );
  }
}
