import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_custom_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewButtons extends StatelessWidget {
  const LeadOverviewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 30),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Edit",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showCustomDeleteDialog(
                context,
                onConfirm: () {
                  print("Item deleted successfully!");
                },
              );

            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 30),
              backgroundColor: Get.theme.colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Delete",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
