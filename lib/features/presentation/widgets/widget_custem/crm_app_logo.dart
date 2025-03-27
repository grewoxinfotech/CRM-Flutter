import 'package:crm/features/data/resources/icon_resources.dart';
import 'package:flutter/material.dart';

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
          child: Image.asset(IconResources.LOGO, width: width ?? 40),
        ),
        if (showTitle) ...[
          const SizedBox(width: 15),
          Text(
            "Grewox",
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}
