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
        color: Get.theme.colorScheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(AppRadius.large - AppPadding.small),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CrmCard(
              width: 50,
              height: 50,
              color: color,
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(AppRadius.medium),
              child: CrmIc(
                iconPath: iconPath.toString(),
                color: Get.theme.colorScheme.surface,
                width: 24,
              ),
            ),
            Column(
              children: [
                Text(
                  title.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
