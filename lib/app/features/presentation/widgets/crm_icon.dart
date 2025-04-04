import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrmIcon extends StatelessWidget {
  final String iconPath;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final Color color;
  final AlignmentGeometry alignment;

  const CrmIcon({
    super.key,
    required this.iconPath,
    this.onTap,
    this.width = 24,
    this.height,
    this.color = Colors.black,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => print(iconPath),
      child: SvgPicture.asset(
        iconPath,
        color: color,
        width: width,
        height: height,
        alignment: alignment,
      ),
    );
  }
}
