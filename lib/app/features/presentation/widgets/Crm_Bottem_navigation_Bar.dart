import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBottomNavigationBar extends StatefulWidget {
  @override
  _CrmBottomNavigationBarState createState() => _CrmBottomNavigationBarState();
}

final navigationBarController = Get.put(NavigationBarController());

class _CrmBottomNavigationBarState extends State<CrmBottomNavigationBar> {
  final List<Map<String, dynamic>> navItems = [
    {"icon": ICRes.add, "label": "Home"},
    {"icon": ICRes.notifications, "label": "Alerts"},
    {"icon": ICRes.notifications, "label": "Alerts"},
    {"icon": ICRes.settings, "label": "Settings"},
    {"icon": ICRes.project, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      width: 600,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.all(5),
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
