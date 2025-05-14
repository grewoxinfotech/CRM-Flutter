import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
