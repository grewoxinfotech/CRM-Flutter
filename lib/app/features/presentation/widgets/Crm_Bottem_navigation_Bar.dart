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
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.notifications, "label": "Alerts"},
    {"icon": Icons.settings, "label": "Settings"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (i) {
          controller.selectedIndex.value == i;
          print(navItems.length.toString());
          return GestureDetector(
            onTap: () => controller.changescreen(i),
            child: FittedBox(
              child: Obx(
                () => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: controller.selectedIndex.value == i ? 40 : 40,
                  width: controller.selectedIndex.value == i ? 40 : 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color:
                        (controller.selectedIndex.value == i)
                            ? Get.theme.colorScheme.primary
                            : Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => setState(
                          () => (controller.selectedIndex.value = i),
                        ),
                    child: Column(
                      children: [
                        CrmIcon(iconPath: ICRes.task),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    (controller.selectedIndex.value == i)
                                        ? Get.theme.colorScheme.primary
                                        : Colors.transparent,
                                child: Icon(
                                  navItems[i]["icon"],
                                  size:
                                      (controller.selectedIndex.value == i)
                                          ? 24
                                          : 24,
                                  color:
                                      (controller.selectedIndex.value == i)
                                          ? Colors.white
                                          : Get.theme.colorScheme.primary,
                                ),
                              ),],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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

  void changescreen(int index) {
    selectedIndex.value = index;
  }
}
