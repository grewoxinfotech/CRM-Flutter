import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmAppLogo extends StatelessWidget {
  final double? width;
  final bool showTitle; // Made final

  const CrmAppLogo({super.key, this.width, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: "applogo",
          child: Image.asset(ICRes.appLogoPNG, width: width ?? 40),
        ),
        if (showTitle) ...[
          const SizedBox(width: 5),
          Text(
            "Grewox",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ],
      ],
    );
  }
}
