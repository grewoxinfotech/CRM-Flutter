import 'package:crm_flutter/app/care/constants/ic_res.dart';
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
        child: Image.asset(Ic.appLogoPNG, width: width ?? 40),
      ),
    );
  }
}
