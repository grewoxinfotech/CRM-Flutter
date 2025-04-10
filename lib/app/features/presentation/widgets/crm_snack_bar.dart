import 'package:flutter/material.dart';
import 'package:get/get.dart';

void crmSnackbar(String title, String msg, {bool isError = false}) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(50),
    animationDuration: const Duration(milliseconds: 300),
    colorText: Get.theme.colorScheme.surface,
    backgroundColor: (isError) ? Get.theme.colorScheme.error.withAlpha(100) : Get.theme.colorScheme.primary.withAlpha(100),
  );
}
