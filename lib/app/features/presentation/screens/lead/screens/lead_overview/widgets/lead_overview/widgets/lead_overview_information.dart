import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadOverviewInformation extends StatelessWidget {
  final LeadModel lead;

  const LeadOverviewInformation({Key? key, required this.lead})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          tile(
            "Lead Value",
            lead.leadMembers != null ? "${lead.leadValue}" : "0",
            Colors.green,
            Icons.ac_unit_outlined,
            double.infinity,
          ),
          const SizedBox(height: 5),
          tile(
            "Created",
            DateFormat('dd/MM/yyyy').format(DateTime.parse(lead.createdAt!)),
            Colors.purple,
            Icons.ac_unit_outlined,
            double.infinity,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // dummy Interest Level
              Expanded(
                child: tile(
                  "Interest Level",
                  "Hight",
                  Colors.red,
                  Icons.add,
                  0,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: tile(
                  "Lead Mamber",
                  lead.leadMembers != null ? "${lead.leadMembers}" : "0",
                  Colors.pink,
                  Icons.man_2_rounded,
                  0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget tile(String title, String subtitle, Color color, icon, double? width) {
  return CrmContainer(
    width: width,
    height: 70,
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
            Icon(icon, color: color.withOpacity(0.75), size: 18),
          ],
        ),
        Divider(height: 10, color: color.withOpacity(0.2)),
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
