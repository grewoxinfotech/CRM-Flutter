import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewIdInformation2 extends StatelessWidget {
  LeadOverviewIdInformation2({super.key});

  final List title = ["SOURCE", "STAGE", "CATEGORY", "STATUS"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: title.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return tile(title[i], "123", () {});
        },
      ),
    );
  }
}

Widget tile(String title, String subtitle, GestureTapCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      child: CrmContainer(
        width: 150,
        height: 85,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.primary,
              ),
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
