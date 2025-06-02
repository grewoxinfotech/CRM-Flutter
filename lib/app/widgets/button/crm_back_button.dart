import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CrmBackButton extends StatelessWidget {
  final double width;
  final double iconSize;
  final Color? color;
  final VoidCallback? onTap;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? tooltip;
  final BoxDecoration? decoration;

  const CrmBackButton({
    super.key,
    this.width = 40,
    this.iconSize = 20,
    this.color,
    this.onTap,
    this.alignment = Alignment.center,
    this.padding,
    this.margin,
    this.tooltip,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      width: width,
      height: width,
      padding: padding ?? EdgeInsets.all(4),
      margin: margin,
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
      child: CrmIc(
        icon: LucideIcons.chevronLeft,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
        size: iconSize,
        onTap: onTap ?? Get.back,
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Align(
      alignment: alignment,
      child: Obx(() => button),
    );
  }
}
