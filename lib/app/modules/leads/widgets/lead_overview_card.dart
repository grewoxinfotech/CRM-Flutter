import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadOverviewCard extends StatelessWidget {
  final String? id;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final String? leadValue;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? telephone;
  final String? email;
  final String? address;
  final String? leadMembers;
  final String? source;
  final String? category;
  final String? files;
  final String? status;
  final String? interestLevel;
  final String? leadScore;
  final String? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const LeadOverviewCard({
    super.key,
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.address,
    this.leadMembers,
    this.source,
    this.category,
    this.files,
    this.status,
    this.interestLevel,
    this.leadScore,
    this.isConverted,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
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
                        leadTitle.toString(),
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
                              leadTitle.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              companyName.toString(),
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
                      items(ICRes.mailSVG, email ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.call, telephone ?? "N/A"),
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
                  leadMembers.toString(),
                  Colors.green,
                  Icons.ac_unit_outlined,
                  double.infinity,
                ),
                const SizedBox(height: 5),
                tile(
                  "Created",
                  DateFormat(
                    'dd/MM/yyyy',
                  ).format(DateTime.parse(createdAt.toString())),
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
                        leadMembers.toString(),
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
                    Expanded(child: tile2("Source", source.toString())),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Category", category.toString())),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: tile2("Stage", leadStage.toString())),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Status", status.toString())),
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
                  onTap: onEdit,
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
                  onTap: onDelete,
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
      CrmIc(iconPath: iconPath, width: 14, color: Colors.grey.shade700),
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
                color: color.withAlpha(150),
              ),
            ),
            Icon(icon, color: color.withAlpha(150), size: 18),
          ],
        ),
        Divider(height: 10, color: color.withAlpha(50)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
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
        Divider(height: 10, color: Get.theme.colorScheme.primary.withAlpha(70)),
        Text(
          subtitle.toString(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
