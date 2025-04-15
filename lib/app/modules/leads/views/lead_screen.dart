import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_add_screen.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/lead_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadsScreen extends StatelessWidget {
  LeadsScreen({super.key});

  LeadController leadController =Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          (leadController.leadsList.length != 0)
              ? CrmButton(
                title: "Add Lead",
                onTap: () => Get.to(LeadAddScreen()),
              )
              : null,
      appBar: AppBar(
        leading: CrmBackButton(),
        title: Text("Leads"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
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
                          CrmIc(
                            iconPath: ICRes.leads,
                            width: 50,
                            color: Get.theme.colorScheme.onSecondary,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "No Lead Found!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Get.theme.colorScheme.onSecondary,
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
                        onTap: () => Get.to(LeadAddScreen()),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.separated(
                itemCount: leadController.leadsList.length,
                separatorBuilder: (context, s) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final lead = leadController.leadsList[i];

                  String formattedDate = DateFormat('dd MMM yyyy').format(
                    DateTime.parse(
                      lead.createdAt.toString() ?? DateTime.now().toString(),
                    ),
                  );
                  return LeadCard(
                    leadTitle: lead.leadTitle ?? "N/A",
                    leadStage: lead.leadStage ?? "N/A",
                    currency: lead.currency ?? "N/A",
                    leadValue: lead.leadValue.toString() ?? "0",
                    firstName: lead.firstName ?? "N/A",
                    lastName: lead.lastName ?? "N/A",
                    phoneCode: lead.phoneCode ?? "N/A",
                    telephone: lead.telephone ?? "N/A",
                    email: lead.email ?? "N/A",
                    source: lead.source ?? "N/A",
                    category: lead.category ?? "N/A",
                    files: lead.files ?? "N/A",
                    status: lead.status ?? "N/A",
                    companyName: lead.companyName ?? "N/A",
                    clientId: lead.clientId ?? "N/A",
                    createdBy: lead.createdBy ?? "N/A",
                    updatedBy: lead.updatedBy ?? "N/A",
                    createdAt: formattedDate ?? "N/A",
                    updatedAt: lead.updatedAt.toString() ?? "N/A",
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
      ),
    );
  }
}
