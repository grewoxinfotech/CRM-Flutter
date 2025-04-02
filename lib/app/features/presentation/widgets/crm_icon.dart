import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrmIcon extends StatelessWidget {
  final double? size;

  final Color color;
  final String iconPath;
  final AlignmentGeometry alignment;

  const CrmIcon({
    super.key,
    this.size,
    this.color = Colors.black,
    required this.iconPath,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      color: color,
      height: size ?? 24,
      width: size ?? 24,
      alignment: alignment,
      allowDrawingOutsideViewBox: true,
    );
  }
}
