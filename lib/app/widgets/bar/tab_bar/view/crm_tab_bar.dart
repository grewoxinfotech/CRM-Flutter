import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabBarModel> items;

  const CrmTabBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TabBarController>(() => TabBarController());
    final tabBarController = Get.find<TabBarController>();
    return Expanded(
      child: CrmCard(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.small),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: -2,
            offset: Offset(0, 5),
          ),
        ],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.medium - 5),
          child: ListView.separated(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder:
                (context, index) => VerticalDivider(
                  color: Get.theme.dividerColor,
                  width: AppPadding.small,
                  indent: 5,
                  endIndent: 5,
                ),
            itemBuilder: (context, index) {
              tabBarController.selectedIndex.value == index;
              return GestureDetector(
                onTap: () => tabBarController.changeTab(index),
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.small,
                      vertical: AppPadding.small / 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          tabBarController.selectedIndex.value == index
                              ? AppColors.primary.withAlpha(30)
                              : AppColors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.medium - 5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          items[index].iconPath,
                          size: 14,
                          color:
                              tabBarController.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                        ),
                        AppSpacing.horizontalSmall,
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                tabBarController.selectedIndex.value == index
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(25);
}
