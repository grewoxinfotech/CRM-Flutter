import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmNavigationBar extends StatelessWidget {
  const CrmNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NavigationController());
    final controller = Get.find<NavigationController>();

    final items = const [
      NavigationItem(icon: Icons.home),
      NavigationItem(icon: Icons.home),
      NavigationItem(icon: Icons.home),
      NavigationItem(icon: Icons.home),
      NavigationItem(icon: Icons.home),
    ];

    return Obx(
      () => CrmCard(
        margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.small,
        ).copyWith(bottom: AppMargin.small),
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: -2,
            offset: Offset(0, 5),
          ),
        ],
        child: SizedBox(
          height: kToolbarHeight,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = controller.currentIndex.value == index;
                final iconColor = isSelected ? Colors.white : Colors.transparent;

                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Get.theme.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(item.icon, color: iconColor, size: 20)],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;

  const NavigationItem({required this.icon});
}

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
