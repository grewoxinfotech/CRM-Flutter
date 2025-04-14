import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:get/get.dart';

void crmSnackbar(String title, String msg, {bool isError = false}) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    margin: PaddingRes.all5,
    animationDuration: const Duration(milliseconds: 3000),
    colorText: Get.theme.colorScheme.surface,
    backgroundColor:
        (isError) ? Get.theme.colorScheme.error : Get.theme.colorScheme.primary,
  );
}
