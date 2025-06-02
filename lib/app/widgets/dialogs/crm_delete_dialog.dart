import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmDeleteDialog extends StatelessWidget {
  final String? entityType;
  final GestureTapCallback? onConfirm;
  final VoidCallback? onCancel;

  const CrmDeleteDialog({
    super.key,
    this.entityType = "item",
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Obx(
        () => Material(
          color: Get.theme.dialogBackgroundColor.withOpacity(0.7),
          child: Center(
            child: CrmCard(
              width: 300,
              padding: const EdgeInsets.all(AppPadding.medium),
              borderRadius: BorderRadius.circular(AppRadius.medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delete Confirmation",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: FontRes.nuNunitoSans,
                      color: Get.theme.colorScheme.error,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => Text(
                      "Are you sure you want to delete this $entityType?",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontRes.nuNunitoSans,
                        color: Get.theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                          onCancel?.call();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Get.theme.colorScheme.onSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontRes.nuNunitoSans,
                          ),
                        ),
                      ),
                      Obx(
                        () => CrmButton(
                          width: 100,
                          height: 35,
                          title: "Delete",
                          backgroundColor: Get.theme.colorScheme.error,
                          onTap: () {
                            Get.back();
                            onConfirm?.call();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
