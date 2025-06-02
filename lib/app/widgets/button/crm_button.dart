import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final double? width;
  final double? height;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget? child;

  const CrmButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.titleTextStyle,
    this.backgroundColor,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        height: height ?? 200,
        width: width ?? 60,
        color: backgroundColor,
        borderRadius: borderRadius,
        child: Obx(
          () => Text(
            title,
            style:
                titleTextStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
