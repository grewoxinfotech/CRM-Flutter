import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewIdInformation2 extends StatelessWidget {
  LeadOverviewIdInformation2({super.key});

  final List title = ["SOURCE", "STAGE", "CATEGORY", "STATUS"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CrmContainer(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  tile("Source", "Phone", (){}),
                  const SizedBox(height: 10),
                  tile("Category", "Manufacturing", (){}),
                ],
              ),
              Column(
                children: [
                  tile("Stage", "Qualified", (){}),
                  const SizedBox(height: 10),
                  tile("Status", "Cancelled", (){}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget tile(String title, String subtitle, GestureTapCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      child: CrmContainer(
        padding: const EdgeInsets.all(10),
        width: 150,
        height: 80,
        color: Get.theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            Divider(
              height: 10,
              color: Get.theme.colorScheme.primary.withOpacity(0.25),
            ),
            Text(subtitle.toString(), style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    ),
  );
}

// Column(
//   children: [
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Column(
//           children: [
//             tile("SOURCE", "Phone", (){}),
//             tile("STAGE", "Qualified", (){}),
//
//           ],
//         ),
//         Column(
//           children: [tile("CATEGORY", "Menufacturing", (){}),
//             tile("STATUS", "Cancelled", (){}),],
//         ),
//       ],
//     ),
//   ],
// );
