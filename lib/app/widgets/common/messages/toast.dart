import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CrmToast {
  static void show(
      String message, {
        ToastGravity gravity = ToastGravity.BOTTOM,
        Toast length = Toast.LENGTH_SHORT,
        Color backgroundColor = Colors.black87,
        Color textColor = Colors.white,
        double fontSize = 16.0,
      }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: length,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
