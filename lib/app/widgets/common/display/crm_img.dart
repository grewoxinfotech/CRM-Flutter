import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrmImg extends StatelessWidget {
  final String imagePath;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CrmImg({
    super.key,
    required this.imagePath,
    this.onTap,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = SvgPicture.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      alignment: Alignment.center,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: imageWidget,
      );
    } else {
      return imageWidget;
    }
  }
}
