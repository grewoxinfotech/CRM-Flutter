import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CrmNavigationBar extends StatelessWidget {
  final Function(int)? onTap;
  final int currentIndex;

  const CrmNavigationBar({this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: Get.theme.colorScheme.primary,
    );
    final iconSize = 18.0;
    final items = [
      {'icon': LucideIcons.layoutDashboard, 'title': 'Home'},
      {'icon': LucideIcons.target, 'title': 'Leads'},
      {'icon': LucideIcons.clipboardCheck, 'title': 'Tasks'},
      {'icon': LucideIcons.messageCircle, 'title': 'Chats'},
      {'icon': LucideIcons.userCircle, 'title': 'Profile'},
    ];

    return Card(
      elevation: 5,
      shadowColor: Get.theme.colorScheme.surface,
      color: Get.theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.small,
      ).copyWith(bottom: AppMargin.small),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: SizedBox(
        height: kToolbarHeight,
        child: SalomonBottomBar(
          duration: const Duration(milliseconds: 400),
          unselectedItemColor: Get.theme.colorScheme.onPrimary,
          margin: const EdgeInsets.all(AppPadding.small),
          itemShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          itemPadding: const EdgeInsets.all(AppPadding.small),
          currentIndex: currentIndex,
          onTap: onTap,
          items:
              items
                  .map(
                    (item) => SalomonBottomBarItem(
                      icon: Icon(item['icon'] as IconData, size: iconSize),
                      title: Text(item['title'] as String, style: style),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
