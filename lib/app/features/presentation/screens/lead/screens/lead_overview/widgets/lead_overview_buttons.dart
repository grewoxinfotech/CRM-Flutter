import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_custom_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewButtons extends StatelessWidget {
  const LeadOverviewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSize = Size(150, 30); // Define reusable size

    return CrmContainer(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              fixedSize: buttonSize,
              backgroundColor: Get.theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String entityType = "lead";

              showCustomDeleteDialog(
                context: context,
                entityType: entityType,
                onConfirm: () {
                  print("$entityType deleted successfully!");
                },
                onCancel: () {
                  print("$entityType deletion canceled!");
                },
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: buttonSize,
              backgroundColor: Get.theme.colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Delete",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
