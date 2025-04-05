import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBottomNavigationBar extends StatefulWidget {
  @override
  _CrmBottomNavigationBarState createState() => _CrmBottomNavigationBarState();
}

final CrmBottemNavigationBarController controller = Get.put(
  CrmBottemNavigationBarController(),
);

class _CrmBottomNavigationBarState extends State<CrmBottomNavigationBar> {
  final List<Map<String, dynamic>> navItems = [
    {"icon": ICRes.add, "label": "Home"},
    {"icon": ICRes.add, "label": "Home"},
    {"icon": ICRes.notifications, "label": "Alerts"},
    {"icon": ICRes.settings, "label": "Settings"},
    {"icon": ICRes.pin, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      height: 60,
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 20, spreadRadius: -10),

      ],
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (i) {
          controller.selectedIndex.value == i;
          print(navItems.length.toString());
          return GestureDetector(
            onTap: () => controller.changescreen(i),
            child: Obx(
                  () => Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    height: 40,
                    width: 40,
                    duration: Duration(milliseconds: 100),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                      (controller.selectedIndex.value == i)
                          ? Get.theme.colorScheme.primary
                          : Colors.transparent,
                    ),
                  ),
                  CrmIcon(
                    onTap: () => controller.changescreen(i),
                    iconPath: navItems[i]["icon"],
                    color:
                    controller.selectedIndex == i
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CrmBottemNavigationBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    selectedIndex.value = 0;
  }

  void changescreen(int index) {
    selectedIndex.value = index;
  }
}
