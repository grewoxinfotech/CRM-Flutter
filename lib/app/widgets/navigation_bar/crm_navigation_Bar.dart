import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
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
      borderRadius: BorderRadius.circular(20),
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
                  borderRadius: BorderRadius.circular(15),
                  color:
                      (navigationBarController.selectedIndex.value == i)
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.surface,
                ),
                child: CrmIc(
                  iconPath: navItems[i]["icon"],
                  onTap: () => navigationBarController.changescreen(i),
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
