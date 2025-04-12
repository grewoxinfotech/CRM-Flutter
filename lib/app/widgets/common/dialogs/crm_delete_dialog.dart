import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmDeleteDialog extends StatelessWidget {
  final String? entityType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CrmDeleteDialog({
    super.key,
    this.entityType,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CrmCard(
        padding: PaddingRes.all2,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delete Confirmation",
              style: TextStyle(
                fontSize: 16,
                fontFamily: FontRes.nuNunitoSans,
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none,
              ),
            ),
            Space(size: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Are you sure you want to delete this $entityType?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontRes.nuNunitoSans,
                  color: Get.theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Space(size: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    onCancel;
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Get.theme.colorScheme.onSecondary,
                      fontFamily: FontRes.nuNunitoSans,
                    ),
                  ),
                ),
                CrmButton(
                  title: "Delete",
                  backgroundColor: Get.theme.colorScheme.error,
                  onTap: () {
                    Get.back();
                    onConfirm;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
