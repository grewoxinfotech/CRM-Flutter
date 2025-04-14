import 'package:crm_flutter/app/care/constants/size/border_res.dart';
import 'package:crm_flutter/app/care/constants/size/margin_res.dart';
import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTabBar extends StatelessWidget {
  CrmTabBar({Key? key, required this.items}) : super(key: key);
  final List<TabItem> items;

  final CrmTabBarController controller = Get.put(CrmTabBarController());

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      height: 40,
      padding: PaddingRes.all1,
      margin: MarginRes.horizontal2,
      borderRadius: BorderRes.borderR3,
      child: ClipRRect(
        borderRadius: BorderRes.borderR4,
        child: ListView.separated(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder:
              (context, index) => VerticalDivider(
                color: Get.theme.disabledColor,
                width: 10,
                indent: 5,
                endIndent: 5,
              ),
          itemBuilder: (context, index) {
            controller.selectedIndex.value == index;
            print(items.length.toString());
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: FittedBox(
                child: Obx(
                  () => AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 100),
                    padding: PaddingRes.all2,
                    decoration: BoxDecoration(
                      color:
                          controller.selectedIndex.value == index
                              ? Get.theme.colorScheme.primary
                              : null,
                      borderRadius: BorderRes.borderR4,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CrmIc(
                          iconPath: items[index].iconPath,
                          width: 18,
                          color:
                              controller.selectedIndex.value == index
                                  ? Get.theme.colorScheme.surface
                                  : Get.theme.colorScheme.primary,
                        ),
                        const Space(size: 5),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                controller.selectedIndex.value == index
                                    ? Get.theme.colorScheme.surface
                                    : Get.theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TabItem {
  final String iconPath;
  final String label;

  TabItem({required this.iconPath, required this.label});
}

class CrmTabBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex(index);
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex(index); // this should trigger Obx
  }
}
