import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmHeadline extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final bool showTextButton;
  final String buttonText;
  final GestureTapCallback? onTap;

  const CrmHeadline({
    super.key,
    required this.title,
    this.padding,
    this.showTextButton = false,
    this.buttonText = "View All",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppPadding.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Get.theme.colorScheme.onPrimary,
            ),
          ),
          if (showTextButton)  // cleaner conditional
            GestureDetector(
              onTap: onTap,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
