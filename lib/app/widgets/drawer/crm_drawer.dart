import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/views/crm_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/views/hrm_screen.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Controller
class DrawerControllerX extends GetxController {
  RxInt selectedIndex = 0.obs;

  void select(int index) => selectedIndex.value = index;
}

// Model
class DrawerItem {
  final String title;
  final IconData? icon;
  final Widget screen;
  final bool showArrow;

  DrawerItem({
    required this.title,
    this.icon,
    required this.screen,
    this.showArrow = true,
  });
}

// Main Drawer Widget
class CrmDrawer extends StatelessWidget {
  final List<DrawerItem> items = [
    DrawerItem(title: "Dashboard", screen: DashboardScreen(), showArrow: false),
    DrawerItem(title: "CRM", screen: CrmScreen()),
    DrawerItem(title: "Sales", screen: CrmScreen()),
    DrawerItem(title: "Purchase", screen: CrmScreen()),
    DrawerItem(title: "User Management", screen: CrmScreen()),
    DrawerItem(title: "Communication", screen: CrmScreen()),
    DrawerItem(title: "HRM", screen: HrmScreen()),
    DrawerItem(title: "Job", screen: CrmScreen()),
    DrawerItem(title: "Setting", screen: CrmScreen()),
    DrawerItem(title: "Support", screen: CrmScreen()),
  ];

  final drawerController = Get.put(DrawerControllerX());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CrmCard(
        margin: EdgeInsets.only(left: AppMargin.small, bottom: AppMargin.small),
        padding: EdgeInsets.all(14),
        width: Get.width * 0.7,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => ViewScreen(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final isSelected = drawerController.selectedIndex.value == i;
                  return GestureDetector(
                    onTap: () {
                      // drawerController.select(i);
                      Get.back();
                      Get.to(() => item.screen);
                    },
                    child: CrmCard(
                      boxShadow: isSelected ? null : [],
                      height: 45,
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                          ),
                          Obx(
                            () => Expanded(
                              child: Container(
                                height: 45,
                                padding: const EdgeInsets.all(10),
                                color:
                                    isSelected
                                        ? AppColors.primary.withOpacity(0.1)
                                        : null,
                                child: Obx(
                                  () => Row(
                                    children: [
                                      Icon(
                                        item.icon,
                                        size: 18,
                                        color:
                                            isSelected
                                                ? AppColors.primary
                                                : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          item.title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                                isSelected
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                            color:
                                                isSelected
                                                    ? AppColors.primary
                                                    : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                      if (item.showArrow)
                                        Obx(
                                          () => Icon(
                                            LucideIcons.chevronRight,
                                            size: 16,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(),
            Obx(
              () => Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    _bottomItem(
                      title: "Profile",
                      icon: LucideIcons.user,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    _bottomItem(
                      title: "Logout",
                      icon: LucideIcons.logOut,
                      onTap: () {},
                      // onTap: () => AuthController().logout(),
                      iconColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.blue,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        SizedBox(width: 10),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}
