import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();

  void changeTab(int index) {
    selectedIndex(index);
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) =>
      selectedIndex(index); // this should trigger Obx
}
