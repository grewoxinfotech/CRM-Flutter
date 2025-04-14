import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmHeadline extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final bool showViewAll;
  final String? showText;
  final GestureTapCallback? onTap;

  const CrmHeadline({
    super.key,
    required this.title,
    this.padding,
    this.showViewAll = false, // Default value set
    this.showText = "View All",
    this.onTap,
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
            style: TextStyle(
              fontSize: 22,
              color: Get.theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showViewAll)
            GestureDetector(
              onTap: onTap,
              child: Text(
                showText.toString(), // Typo fixed ("Views all" -> "View all")
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
