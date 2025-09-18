import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmSnackBar {
  static void showAwesomeSnackbar({
    required String title,
    required String message,
    required ContentType contentType,
    Color? color,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,

      // clipBehavior: Clip.hardEdge,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: color,
        inMaterialBanner: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        messageTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
