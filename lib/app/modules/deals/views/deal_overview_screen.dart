import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/deal_model.dart';
import 'package:crm_flutter/app/modules/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealOverview extends StatelessWidget {
  // final String

  final String dealId;
  final DealController dealController = Get.put(DealController());
  final List title = ["SOURCE", "STAGE", "CATEGORY", "STATUS"];

  DealOverview({super.key, required this.dealId});

  @override
  Widget build(BuildContext context) {
    if (dealController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (dealController.dealsList.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final deal = dealController.dealsList.firstWhere(
          (deal) => deal.id == dealId,
      orElse: () => DealModel(),
    );

    if (deal.id == null) {
      return const Center(child: Text("Lead not found"));
    }

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
                        deal.dealName != null && deal.dealName!.isNotEmpty
                            ? deal.dealName![0]
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
                              deal.dealName.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              deal.leadTitle.toString(),
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
                      items(ICRes.mailSVG, deal.currency.toString() ?? "N/A"),
                      Divider(color: Colors.grey.shade300, height: 10),
                      items(ICRes.call, deal.price.toString() ?? "N/A"),
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
                  deal.currency.toString() + " : " + deal.price.toString(),
                  Colors.green,
                  Icons.ac_unit_outlined,
                  double.infinity,
                ),
                const SizedBox(height: 5),
                tile(
                  "Created",
                  DateFormat(
                    'dd/MM/yyyy',
                  ).format(DateTime.parse(deal.createdAt.toString())),
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
                        deal.project != null ? "${deal.project}" : "0",
                        Colors.pink,
                        FontAwesomeIcons.manatSign,
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
                    Expanded(child: tile2("Source", "${deal.project}")),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Category", "${deal.project}")),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: tile2("Stage", "${deal.project}")),
                    const SizedBox(width: 5),
                    Expanded(child: tile2("Status", "${deal.project}")),
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
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.error,
                  ),
                  onTap:
                      () => CrmDeleteDialog(
                    entityType: deal.dealName.toString(),
                    onConfirm: () => dealController.deleteDeal(dealId),
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
