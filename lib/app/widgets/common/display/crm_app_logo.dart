import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:flutter/material.dart';

class CrmAppLogo extends StatelessWidget {
  final double? width;
  final GestureTapCallback? onTap;
  final String? heroTag;

  const CrmAppLogo({super.key, this.width, this.onTap, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(ICRes.appLogoPNG, width: width ?? 40);
    
    return GestureDetector(
        onTap: onTap,
      child: heroTag != null
        ? Hero(
            tag: heroTag!,
            child: logo,
          )
        : logo,
    );
  }
}
