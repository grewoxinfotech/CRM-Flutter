// import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void showCustomDeleteDialog(
//   BuildContext context, {
//   required VoidCallback onConfirm,
// }) {
//   Get.dialog(
//     Center(
//       child: CrmContainer(
//         padding: const EdgeInsets.all(20),
//         width: 300, // Responsive width
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Delete Confirmation",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: "NuNUnit_Sans",
//                 color: Get.theme.colorScheme.error,
//                 fontWeight: FontWeight.w800,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Are you sure you want to delete this 'item'? This action cannot be undone.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 14,fontFamily: "NuNUnit_Sans", color: Colors.grey[700],fontWeight: FontWeight.w600,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () => Get.back(), // Close dialog
//                   child: Text("Cancel", style: TextStyle(color: Colors.grey,fontFamily: "NuNUnit_Sans",)),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.back(); // Close dialog first
//                     onConfirm(); // Execute delete action
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Get.theme.colorScheme.error),
//                   child: Text("Delete", style: TextStyle(color: Colors.white,fontFamily: "NuNUnit_Sans",)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//     barrierDismissible: false, // Prevent accidental closing
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';

void showCustomDeleteDialog({
  required BuildContext context,
  required String entityType,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  Get.dialog(
    Center(
      child: CrmContainer(
        padding: const EdgeInsets.all(20),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delete Confirmation",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "NuNUnit_Sans",
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Are you sure you want to delete this $entityType?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "NuNUnit_Sans",
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    onCancel();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "NuNUnit_Sans",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.colorScheme.error,
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "NuNUnit_Sans",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
