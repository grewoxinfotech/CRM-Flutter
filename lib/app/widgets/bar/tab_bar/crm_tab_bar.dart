import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarModel {
  final IconData icon;
  final String label;

  TabBarModel({required this.icon, required this.label});
}

class TabBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class CrmTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabBarModel> items;
  final EdgeInsetsGeometry padding;
  final double height;
  final BorderRadius borderRadius;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final double iconSize;
  final TextStyle? textStyle;

  CrmTabBar({
    Key? key,
    required this.items,
    this.padding = const EdgeInsets.all(5),
    this.height = 30,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.selectedBackgroundColor = const Color(0x553F51B5), // blue with alpha
    this.unselectedBackgroundColor = Colors.transparent,
    this.iconSize = 16,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabBarController());

    return SizedBox(
      height: height,
      child: Obx(() {
        return Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: padding,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 8),
            itemBuilder: (context, index) {
              final selected = controller.selectedIndex.value == index;
              return GestureDetector(
                onTap: () => controller.changeTab(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        selected
                            ? selectedBackgroundColor
                            : unselectedBackgroundColor,
                    borderRadius: borderRadius,
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Icon(
                            items[index].icon,
                            size: iconSize,
                            color: selected ? selectedColor : unselectedColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Obx(
                          () => Text(
                            items[index].label,
                            style:
                                textStyle ??
                                TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      selected
                                          ? selectedColor
                                          : unselectedColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
