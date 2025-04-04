import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTabBar extends StatelessWidget {
  CrmTabBar({Key? key, required this.items}) : super(key: key);
  final List<TabItem> items;
  final CrmTabBarController controller = Get.put(CrmTabBarController());

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
        height: 40,
        padding: const EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ListView.separated(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => VerticalDivider(width: 10,color:Get.theme.colorScheme.outline,indent: 5,endIndent: 5),
            itemBuilder: (context, index) {
              controller.selectedIndex.value == index;
              print(items.length.toString());
              return GestureDetector(
                onTap: () => controller.changeTab(index),
                child: FittedBox(
                  child: Obx(
                    ()=> AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            controller.selectedIndex.value == index
                                ? Get.theme.colorScheme.primary.withOpacity(1)
                                : Get.theme.colorScheme.surface.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CrmIcon(
                            iconPath: items[index].iconPath,
                            width: 15,
                            color:
                            controller.selectedIndex.value == index
                                ? Get.theme.colorScheme.surface
                                : Get.theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            items[index].label,
                            style: TextStyle(
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
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
