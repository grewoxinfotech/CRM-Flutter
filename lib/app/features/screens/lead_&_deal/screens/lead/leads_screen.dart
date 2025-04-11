import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/lead/lead_controller.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/screens/lead/lead_add_screen_1.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/screens/lead/lead_detail_screen.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/widgets/lead_tile.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_headline.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/widgets/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadsScreen extends StatelessWidget {
  LeadsScreen({super.key});

  LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      floatingActionButton:
          (leadController.leadsList.length != 0)
              ? CrmButton(
                title: "Add Lead",
                onTap: () => Get.to(LeadAddScreen1()),
              )
              : null,
      appBar: AppBar(
        title: CrmHeadline(title: "Leads"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (leadController.isLoading.value == false) {
          if (leadController.leadsList.length <= 0) {
            return Center(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CrmIcon(
                          iconPath: ICRes.leads,
                          width: 50,
                          color: COLORRes.TEXT_SECONDARY.withAlpha(100),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Lead Found!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: COLORRes.TEXT_SECONDARY.withAlpha(100),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 80),
                    alignment: Alignment.bottomCenter,
                    child: CrmButton(
                      title: "Add Lead",
                      onTap: () => Get.to(LeadAddScreen1()),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: leadController.leadsList.length,
              separatorBuilder: (context, s) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final lead = leadController.leadsList[i];

                String formattedDate = DateFormat('dd MMM yyyy').format(
                  DateTime.parse(
                    lead.createdAt.toString() ?? DateTime.now().toString(),
                  ),
                );
                return LeadTile(
                  claint_name: lead.firstName ?? "No name",
                  company_name: lead.leadTitle ?? "No name",
                  amount: lead.leadValue.toString() ?? "0",
                  source: lead.source ?? "Unknown",
                  status: "Good",
                  status_color: Colors.green,
                  date: formattedDate,
                  onTap:
                      () =>
                          (lead.id != null)
                              ? Get.to(
                                () => LeadDetailsScreen(leadId: lead.id!),
                              )
                              : Get.snackbar('Error', 'Lead ID is missing'),
                );
              },
            );
          }
        } else {
          return CrmLoadingCircle();
        }
      }),
    );
  }
}
