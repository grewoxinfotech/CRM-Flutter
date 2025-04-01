import 'dart:ffi';

import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewInformation extends StatelessWidget {
  const LeadOverviewInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          tile(
            "Lead Value",
            "15648/-",
            Colors.green,
            Icons.ac_unit_outlined,
              double.infinity
          ),
          const SizedBox(height: 10),
          tile(
            "Created",
            "3/35/2025",
            Colors.purple,
            Icons.ac_unit_outlined,
              double.infinity
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              tile("Interest Level", "Hight", Colors.red, Icons.add,150),
              tile("Lead Mamber", "45", Colors.pink, Icons.man_2_rounded,150),

            ],
          ),
        ],
      ),
    );
  }
}

Widget tile(String title, String subtitle, Color color, icon,double? width) {
  return CrmContainer(
    width: width,
    height: 75,
    padding: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    color: Get.theme.colorScheme.background,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color.withOpacity(0.75),
              ),
            ),
            Icon(icon, color: color.withOpacity(0.75),size: 18),
          ],
        ),
        Divider(
          height: 10,
          color: color.withOpacity(0.2),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color.withOpacity(1),
          ),
        ),
      ],
    ),
  );
}
