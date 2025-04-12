import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CrmImg extends StatelessWidget {
  final String imagePath;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;

  const CrmImg({
    super.key,
    required this.imagePath,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => print(imagePath),
      child: SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        alignment: Alignment.center,
      ),
    );
  }
}
