import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subTitle;
  final String? iconPath;
  final Color? color;

  const FunctionCard({
    super.key,
    this.iconPath,
    this.color,
    this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        color: Get.theme.colorScheme.primary.withAlpha(10),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CrmCard(
              width: 50,
              height: 50,
              color: color,
        borderRadius: BorderRadius.circular(15),
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

                Text(
                  subTitle.toString() + " Items",
                  style: TextStyle(
                    fontSize: 10,
                    color: Get.theme.colorScheme.onSecondary,
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
