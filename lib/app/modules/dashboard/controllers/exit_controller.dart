import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ExitController extends GetxController {
  DateTime? _lastBackPressed;

  Future<bool> handleBackPress() async {
    final now = DateTime(2024);
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;

      Fluttertoast.showToast(
        msg: "Press back again to exit.",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: AppColors.textPrimary,
        textColor: Colors.black,
      );

      return false; // Don’t close yet
    }
    return true; // Close the app
  }
}
