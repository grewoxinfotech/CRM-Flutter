import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/lead/lead_controller.dart';
import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_delete_dialog.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadOverview extends StatelessWidget {
  // final String

  final String leadId;
  final LeadController leadController = Get.put(LeadController());
  final List title = ["SOURCE", "STAGE", "CATEGORY", "STATUS"];

  LeadOverview({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    if (leadController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (leadController.leadsList.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final lead = leadController.leadsList.firstWhere(
      (lead) => lead.id == leadId,
      orElse: () => LeadModel(),
    );

    if (lead.id == null) {
      return const Center(child: Text("Lead not found"));
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CrmCard(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade50, // xxx
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        lead.leadTitle != null && lead.leadTitle!.isNotEmpty
                            ? lead.leadTitle![0]
                            : "T", // xxx
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: CrmCard(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        color: Get.theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lead.leadTitle.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              lead.companyName.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 10,
                  indent: 5,
                  endIndent: 5,
                ),

                CrmCard(
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(10),
                  color: Get.theme.colorScheme.background,
                  child: Column(
                    children: [
                      items(ICRes.mailSVG, lead.email ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.call, lead.telephone ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.location, "lead.city" ?? "N/A"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CrmCard(
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
                  DateFormat(
                    'dd/MM/yyyy',
                  ).format(DateTime.parse(lead.createdAt.toString())),
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
          ),
          const SizedBox(height: 5),
          CrmCard(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: tile2("Source", "${lead.source}")),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Category", "${lead.category}")),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: tile2("Stage", "${lead.leadStage}")),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Status", "${lead.status}")),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CrmButton(
                  title: "Edit",
                  onTap: () {},
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CrmButton(
                  title: "Delete",
                  backgroundColor: Get.theme.colorScheme.surface,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Get.theme.colorScheme.error,
                  ),
                  onTap:
                      () => CrmDeleteDialog(
                        entityType: lead.leadTitle.toString(),
                        onConfirm: () => leadController.deleteLead(leadId),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget items(String iconPath, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CrmIcon(iconPath: iconPath, width: 14, color: Colors.grey.shade700),
      const SizedBox(width: 10),
      Text(
        title.toString(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    ],
  );
}

Widget tile(String title, String subtitle, Color color, icon, double? width) {
  return CrmCard(
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

Widget tile2(String title, String subtitle) {
  return CrmCard(
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
        Text(
          subtitle.toString(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
