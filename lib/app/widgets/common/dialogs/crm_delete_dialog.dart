import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmDeleteDialog extends StatelessWidget {
  final String? entityType;
  final GestureTapCallback? onConfirm;
  final VoidCallback? onCancel;

  const CrmDeleteDialog({
    super.key,
    this.entityType,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.3), // Slight transparent backdrop
        child: Material(
          color: Colors.transparent,
          elevation: 0, // Remove default heavy elevation
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(AppPadding.medium),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // softer shadow
                  blurRadius: 12, // smooth edges
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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
                AppSpacing.verticalSmall,
                Text(
                  "Are you sure you want to delete this $entityType?",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: FontRes.nuNunitoSans,
                    color: Get.theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
                AppSpacing.verticalSmall,
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
                    CrmButton(
                      width: 100,
                      height: 35,
                      backgroundColor: Get.theme.colorScheme.error,
                      title: "Delete",
                      onTap: () {
                        Get.back();
                        onConfirm?.call();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
