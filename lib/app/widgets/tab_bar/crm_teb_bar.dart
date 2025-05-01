import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTabBar extends StatelessWidget {
  CrmTabBar({Key? key, required this.items}) : super(key: key);
  final List<TabItem> items;

  final CrmTabBarController controller = Get.put(CrmTabBarController());

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      height: 40,
      shadowColor: Get.theme.colorScheme.surface,
      elevation: 5,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.large - AppPadding.small),
        child: ListView.separated(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder:
              (context, index) => VerticalDivider(
                color: Get.theme.dividerColor,
                width: 10,
                indent: 5,
                endIndent: 5,
              ),
          itemBuilder: (context, index) {
            controller.selectedIndex.value == index;
            print(items.length.toString());
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: FittedBox(
                child: Obx(
                  () => AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          controller.selectedIndex.value == index
                              ? Get.theme.colorScheme.primary
                              : null,
                      borderRadius: BorderRadius.circular(AppRadius.large - AppPadding.small),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CrmIc(
                          iconPath: items[index].iconPath,
                          width: 18,
                          color:
                              controller.selectedIndex.value == index
                                  ? Get.theme.colorScheme.surface
                                  : Get.theme.colorScheme.primary,
                        ),
                    const SizedBox(height: 5),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                controller.selectedIndex.value == index
                                    ? Get.theme.colorScheme.surface
                                    : Get.theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TabItem {
  final String iconPath;
  final String label;

  TabItem({required this.iconPath, required this.label});
}

class CrmTabBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex(index);
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex(index); // this should trigger Obx
  }
}
