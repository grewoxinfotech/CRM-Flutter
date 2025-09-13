import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? iconPath;
  final Color? color;

  const FunctionCard({
    super.key,
    this.iconPath,
    this.color,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        color: Get.theme.colorScheme.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(AppRadius.large - AppPadding.small),
        boxShadow: [], // no shadow for outer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CrmCard(
              width: 50,
              height: 50,
              color: color ?? Get.theme.colorScheme.primary,
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(AppRadius.medium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              child: CrmIc(
                iconPath: iconPath ?? '',
                color: Get.theme.colorScheme.surface,
                width: 24,
              ),
            ),
            Text(
              title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Get.theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
