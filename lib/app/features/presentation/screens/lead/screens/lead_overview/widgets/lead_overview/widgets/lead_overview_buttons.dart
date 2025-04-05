import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewButtons extends StatelessWidget {
  final VoidCallback? editButton;
  final VoidCallback? deleteButton;

  const LeadOverviewButtons({super.key, this.editButton, this.deleteButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CrmButton(
              title: "Edit",
              onPressed: editButton,
              backgroundColor: Get.theme.colorScheme.surface,
              titleTextColor: Colors.green,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 5,),
          Expanded(
            child: CrmButton(
              title: "Delete",
              backgroundColor: Get.theme.colorScheme.surface,
              titleTextColor: Colors.red,
              fontSize: 20,
              onPressed: deleteButton,
            ),
          ),
        ],
      ),
    );
  }
}
