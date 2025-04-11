import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';

class CrmHeadline extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final String showtext;
  final GestureTapCallback? onTap;
  final bool showViewAll;

  const CrmHeadline({
    super.key,
    required this.title,
    this.padding,
    this.showtext = "View All",
    this.onTap,
    this.showViewAll = false, // Default value set
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style:  TextStyle(fontSize: 22,
                color: COLORRes.TEXT_PRIMARY,
                fontWeight: FontWeight.w700),
          ),
          if (showViewAll)
            GestureDetector(
              onTap: onTap,
              child: Text(
                showtext, // Typo fixed ("Views all" -> "View all")
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
