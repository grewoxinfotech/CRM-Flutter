import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ListView.separated(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
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
                                ? Get.theme.colorScheme.primary.withOpacity(0.2)
                                : Get.theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            items[index].imagePath,
                            width: 15,
                            color:
                            controller.selectedIndex.value == index
                                ? Get.theme.colorScheme.primary
                                : Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            items[index].label,
                            style: TextStyle(
                              color:
                              controller.selectedIndex.value == index
                                  ? Get.theme.colorScheme.primary
                                  : Colors.grey,
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
  final String imagePath;
  final String label;

  TabItem({required this.imagePath, required this.label});
}

class CrmTabBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
