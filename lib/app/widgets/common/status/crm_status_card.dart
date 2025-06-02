import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class CrmStatusCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final String? title;
  final String? status;  // <-- add this
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final IconData? icon;

  const CrmStatusCard({
    super.key,
    this.title,
    this.status,  // <-- add this
    this.color = Colors.grey,
    this.borderRadius,
    this.padding,
    this.fontSize,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      height: height,
      width: width,
      color: color!.withAlpha(50),
      boxShadow: [],
      borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.small),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppPadding.small,
            vertical: AppPadding.small / 4,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: fontSize ?? 14,
              color: color,
            ),
            const SizedBox(width: 4),
          ],
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: fontSize ?? 12,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          if (status != null) ...[
            const SizedBox(width: 6),
            Text(
              status!,
              style: TextStyle(
                fontSize: fontSize ?? 12,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
