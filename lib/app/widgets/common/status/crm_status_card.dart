import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class CrmStatusCard extends StatelessWidget {
  final Color? color;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const CrmStatusCard({
    super.key,
    this.title,
    this.color = Colors.grey,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      color: color!.withAlpha(50),
      boxShadow: [],
      borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.small),
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: AppPadding.small,
        vertical: AppPadding.small / 4,
      ),

      child: Text(
        title!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
