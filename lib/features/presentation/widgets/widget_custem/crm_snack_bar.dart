import 'package:flutter/material.dart';
import 'package:get/get.dart';

void crmSnackbar(String title, String msg, {bool isError = false}) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(50),
    animationDuration: const Duration(milliseconds: 300),
    colorText: Colors.white,
    backgroundColor: (isError) ? Colors.red.shade900 : Colors.green.shade900,
  );
}
