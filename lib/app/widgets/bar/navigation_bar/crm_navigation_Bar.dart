import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/job/job_functions/view/job_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CrmNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NavigationController>(() => NavigationController());
    NavigationController controller = Get.find();
    TextStyle style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: Get.theme.colorScheme.primary,
    );
    double iconSize = 18;

    return Obx(
      () => Card(
        elevation: 5,
        shadowColor: Get.theme.colorScheme.surface,
        color: Get.theme.colorScheme.surface,
        margin: EdgeInsets.only(
          left: AppMargin.small,
          bottom: AppMargin.small,
          right: AppMargin.small,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Container(
          height: kToolbarHeight,
          alignment: Alignment.center,
          child: SalomonBottomBar(
            duration: const Duration(milliseconds: 400),
            unselectedItemColor: Get.theme.colorScheme.onPrimary,
            margin: const EdgeInsets.all(AppPadding.small),
            itemShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
            itemPadding: EdgeInsets.all(AppPadding.small),
            currentIndex: controller.currentIndex.value,
            onTap: (i) => controller.changeIndex(i),
            items: [
              SalomonBottomBarItem(
                icon: CrmIc(iconPath: ICRes.dashboard),

                title: Text("Dashboard", style: style),
              ),

              SalomonBottomBarItem(
                icon: CrmIc(iconPath: ICRes.crm),
                title: Text("Crm", style: style),
              ),

              SalomonBottomBarItem(
                icon: CrmIc(iconPath: ICRes.sales),

                title: Text("Sales", style: style),
              ),

              SalomonBottomBarItem(
                icon: CrmIc(iconPath: ICRes.purchase),

                title: Text("purchase", style: style),
              ),

              SalomonBottomBarItem(
                icon: CrmIc(iconPath: ICRes.hrm),

                title: Text("Hrm", style: style),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxInt currentIndex = 0.obs;

  changeIndex(int i) {
    return currentIndex(i);
  }
}
