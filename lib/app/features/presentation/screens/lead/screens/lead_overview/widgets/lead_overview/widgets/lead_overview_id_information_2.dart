import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LeadOverviewIdInformation2 extends StatelessWidget {
  final LeadModel lead;

  LeadOverviewIdInformation2({Key? key, required this.lead}) : super(key: key);

  final List title = ["SOURCE", "STAGE", "CATEGORY", "STATUS"];

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: tile("Source", "${lead.source}")),
              const SizedBox(width: 5),
              Expanded(child: tile("Category", "${lead.category}")),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Expanded(child: tile("Stage", "${lead.leadStage}")),
              const SizedBox(width: 5),
              Expanded(child: tile("Status", "${lead.status}" )),
            ],
          ),
        ],
      ),
    );
  }
}

Widget tile(String title, String subtitle) {
  return CrmContainer(
    height: 70,
    padding: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(10),
    color: Get.theme.colorScheme.background,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        Divider(
          height: 10,
          color: Get.theme.colorScheme.primary.withOpacity(0.25),
        ),
        Text(subtitle.toString(), style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
