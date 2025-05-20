import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/auth/controllers/auth_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/drawer/views/deawer_controller.dart';
import 'package:crm_flutter/app/widgets/drawer/views/drawer_model.dart';
import 'package:crm_flutter/app/widgets/drawer/widgets/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CrmDrawer extends StatelessWidget {
  const CrmDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    CrmDrawerController drawerController = Get.put(CrmDrawerController());
    List<DrawerModel> items = DrawerModel.getDrowerItems();

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
                  color: (j == i) ? primary : textSecondary,
                  isSelected: (j == i) ? true : false,
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
              iconData: FontAwesomeIcons.solidUserCircle,
              title: "Profile",
              color: textSecondary,
            ),
            DrawerCard(
              onTap: () => AuthController().logout(),
              iconData: FontAwesomeIcons.signOutAlt,
              title: "Logout",
              color: textSecondary,
            ),
            AppSpacing.verticalSmall,
          ],
        ),
      ),
    );
  }
}
