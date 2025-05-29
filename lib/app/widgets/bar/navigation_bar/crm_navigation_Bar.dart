import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CrmNavigationBar extends StatelessWidget {
  final Function(int)? onTap;
  final int currentIndex;

  const CrmNavigationBar({super.key, this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': LucideIcons.home, 'title': 'Home'},
      {'icon': LucideIcons.target, 'title': 'Leads'},
      {'icon': LucideIcons.clipboardCheck, 'title': 'Tasks'},
      {'icon': LucideIcons.messageSquare, 'title': 'Chats'},
      {'icon': LucideIcons.user, 'title': 'Profile'},
    ];

    return Card(
      elevation: 3,
      shadowColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.small,
      ).copyWith(bottom: AppMargin.small),
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = index == currentIndex;
            final iconColor =
                isSelected
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.onPrimary;

            return GestureDetector(
              onTap: () => onTap?.call(index),
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Get.theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: iconColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
