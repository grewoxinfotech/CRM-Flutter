import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CrmCard(
        child: Column(
          children: [
            /// Title and Customer Number
            Obx(
              () => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Get.theme.colorScheme.primary.withAlpha(30),
                  child: Text(
                    "N/A"[0].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ),
                title: Obx(
                  () => Text(
                    'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ),
                subtitle: Text(
                  "N/A",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                trailing: Obx(
                  () => Text(
                    "N/A",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
