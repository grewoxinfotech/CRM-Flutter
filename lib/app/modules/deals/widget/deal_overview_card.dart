import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/file_model.dart';
import 'package:crm_flutter/app/data/models/system/product_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealOverviewCard extends StatelessWidget {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final String? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final String? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final String? products;
  final String? files;
  final String? assignedTo;
  final String? clientId;
  final String? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const DealOverviewCard({
    super.key,
    this.id,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.closedDate,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onDelete,
    this.onEdit,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                        dealTitle.toString(), // xxx
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
                              dealTitle.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              dealTitle.toString(),
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
                      items(ICRes.mailSVG, currency.toString() ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.call, value.toString() ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.location, "deal.city" ?? "N/A"),
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
                  "Deal Value",
                  value.toString(),
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
                        "Deal Mamber",
                        "s",
                        Colors.pink,
                        FontAwesomeIcons.arrowRightFromBracket,
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
                    Expanded(child: tile2("Source", dealTitle.toString())),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Category", dealTitle.toString())),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: tile2("Stage", dealTitle.toString())),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Status", dealTitle.toString())),
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
                    fontWeight: FontWeight.w700,
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
        Divider(height: 10, color: color.withAlpha(100)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color.withAlpha(20),
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
          color: Get.theme.colorScheme.primary.withAlpha(50),
        ),
        Text(
          subtitle.toString(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
