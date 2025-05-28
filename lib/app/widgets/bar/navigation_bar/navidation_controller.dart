import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
