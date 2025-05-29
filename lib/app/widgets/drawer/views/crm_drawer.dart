import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/drawer/views/deawer_controller.dart';
import 'package:crm_flutter/app/widgets/drawer/views/drawer_model.dart';
import 'package:crm_flutter/app/widgets/drawer/widgets/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CrmDrawer extends StatelessWidget {
  const CrmDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    CrmDrawerController drawerController = Get.put(CrmDrawerController());
    List<DrawerModel> items = DrawerModel.getDrawerItems();

    return SafeArea(
      child: CrmCard(
        width: Get.width * 0.7,
        margin: const EdgeInsets.only(
          left: AppPadding.small,
          bottom: AppPadding.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewScreen(
              itemCount: items.length,
              padding: EdgeInsets.all(AppMargin.small),
              itemBuilder: (context, i) {
                final j = drawerController.selextedIndex.value;
                return DrawerCard(
                  title: items[i].title!,
                  iconData: items[i].iconData,
                  color: (j == i) ? AppColors.primary : AppColors.textSecondary,
                  isSelected: (j == i) ? true : false,
                  showArrowRight: items[i].showArrowRight,
                  onTap: () {
                    Get.back();
                    drawerController.onchange(i);
                    (drawerController.selextedIndex.value == i)
                        ? Get.to(items[i].widget)
                        : null;
                  },
                );
              },
            ),
            Spacer(),
            DrawerCard(
              onTap: () {},
              iconData: LucideIcons.user,
              title: "Profile",
              showArrowRight: false,
              iconColor: Colors.blue,
              color: AppColors.textSecondary,
            ),
            DrawerCard(
              onTap: () => AuthController().logout(),
              iconData: LucideIcons.logOut,
              title: "Logout",
              showArrowRight: false,
              iconColor: Colors.red ,
              color: AppColors.textSecondary,
            ),
            AppSpacing.verticalSmall,
          ],
        ),
      ),
    );
  }
}
