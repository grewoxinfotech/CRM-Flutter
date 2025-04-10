import 'package:flutter/material.dart';

class CrmHeadline extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String showtext;
  final bool showViewAll;

  const CrmHeadline({
    super.key,
    required this.title,
    this.padding,
    this.onTap,
    this.showtext = "View All",
    this.showViewAll = false, // Default value set
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
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
