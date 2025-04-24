import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CrmNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    TextStyle style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: Get.theme.colorScheme.primary,
    );

    return Obx(
      () => CrmCard(
        elevation: 5,
        shadowColor: Colors.black26,
        margin: const EdgeInsets.only(left: 5, bottom: 10, right: 5),
        borderRadius: BorderRadius.circular(19),
        child: SalomonBottomBar(
          margin: const EdgeInsets.all(5),
          duration: const Duration(milliseconds: 400),
          backgroundColor: Colors.transparent,
          unselectedItemColor: Get.theme.colorScheme.onPrimary,
          itemShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.changeIndex(i),
          items: [
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.instagram, size: 18),
              title: Text("Instagram", style: style),
            ),

            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.whatsapp, size: 18),
              title: Text("whatsapp", style: style),
            ),

            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.facebookF, size: 18),
              title: Text("facebook", style: style),
            ),

            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.google, size: 18),
              title: Text("google", style: style),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  changeIndex(int i) => currentIndex(i);
}
