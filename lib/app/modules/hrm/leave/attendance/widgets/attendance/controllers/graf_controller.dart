import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrafController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble progress = 0.0.obs;

  void startAnimation(double targetPercentage) {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0, end: targetPercentage).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    )..addListener(() {
      progress.value = animation.value;
    });

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
