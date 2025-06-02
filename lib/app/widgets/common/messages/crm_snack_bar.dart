import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmSnackBar {
  /// Show a customizable awesome snackbar.
  ///
  /// [title] and [message] are required strings.
  /// [contentType] determines the snackbar style and icon.
  /// [color] overrides the default color for the content type.
  /// [duration] controls how long the snackbar stays visible.
  /// [action] optionally adds an action button to the snackbar.
  static void showAwesomeSnackbar({
    required String title,
    required String message,
    required ContentType contentType,
    Color? color,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    final context = Get.context;
    if (context == null) {
      debugPrint("CrmSnackBar: Get.context is null, cannot show snackbar.");
      return;
    }

    // Assign default color based on contentType if color not provided
    final contentColor = color ?? _defaultColorForContentType(contentType);

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: duration,
      action: action,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: contentColor,
        inMaterialBanner: true,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        messageTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color _defaultColorForContentType(ContentType contentType) {
    switch (contentType) {
      case ContentType.success:
        return Colors.green.shade600;
      case ContentType.failure:
        return Colors.red.shade600;
      case ContentType.warning:
        return Colors.orange.shade600;
      case ContentType.help:
        return Colors.blue.shade600;
      default:
        return Colors.blueGrey;
    }
  }
}
