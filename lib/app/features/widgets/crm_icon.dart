import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrmIcon extends StatelessWidget {
  final String iconPath;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;

  const CrmIcon({
    super.key,
    required this.iconPath,
    this.onTap,
    this.width = 24,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => print(iconPath),
      child: SvgPicture.asset(
        iconPath,
        color: color ?? COLORRes.TEXT_PRIMARY,
        width: width,
        height: height,
        alignment: Alignment.center,
      ),
    );
  }
}
