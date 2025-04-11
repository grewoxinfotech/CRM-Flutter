import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmNavigationBar extends StatelessWidget {
  final List<Map<String, dynamic>> navItems = [
    {"icon": ICRes.add, "label": "Home"},
    {"icon": ICRes.notifications, "label": "Alerts"},
    {"icon": ICRes.notifications, "label": "Alerts"},
    {"icon": ICRes.settings, "label": "Settings"},
    {"icon": ICRes.project, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      height: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      boxShadow: [
        BoxShadow(
          color: Get.theme.colorScheme.shadow.withAlpha(100),
          blurRadius: 20,
        ),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(navItems.length, (i) {
          navigationBarController.selectedIndex.value == i;
          return GestureDetector(
            onTap: () => navigationBarController.changescreen(i),
            child: Obx(
              () => AnimatedContainer(
                height: 40,
                width: 40,
                duration: const Duration(milliseconds: 100),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      (navigationBarController.selectedIndex.value == i)
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.surface,
                ),
                child: CrmIcon(
                  onTap: () => navigationBarController.changescreen(i),
                  iconPath: navItems[i]["icon"],
                  color:
                      (navigationBarController.selectedIndex.value == i)
                          ? Get.theme.colorScheme.surface
                          : Get.theme.colorScheme.primary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

final navigationBarController = Get.put(NavigationBarController());

class NavigationBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changescreen(int index) => selectedIndex(index);

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    selectedIndex(0);
  }
}
