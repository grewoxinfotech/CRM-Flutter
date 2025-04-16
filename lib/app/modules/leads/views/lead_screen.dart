import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_add_screen.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/leads/widgets/lead_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadScreen extends StatelessWidget {
  LeadScreen({super.key});

  LeadController leadController = Get.put(LeadController());

  addButton() =>
      CrmButton(title: "Add Lead", onTap: () => Get.to(LeadAddScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        centerTitle: false,
        title: Text("Leads"),
      ),
      floatingActionButton: addButton(),
      body: Obx(() {
        if (leadController.isLoading.value == false) {
          if (leadController.leadsList.isEmpty) {
            return Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CrmIc(
                      iconPath: ICRes.leads,
                      width: 50,
                      color: Get.theme.colorScheme.onBackground,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "No Lead Found!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Get.theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: leadController.leadsList.length,
              separatorBuilder: (context, s) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final lead = leadController.leadsList[i];

                String formattedDate = DateFormat('dd MM yyyy').format(
                  DateTime.parse(
                    (lead.createdAt.toString().isNotEmpty)
                        ? lead.createdAt.toString()
                        : DateTime.now().toString(),
                  ),
                );
                return LeadCard(
                  id: lead.id.toString(),
                  inquiryId: lead.inquiryId.toString(),
                  leadTitle: lead.leadTitle.toString(),
                  leadStage: lead.leadStage.toString(),
                  pipeline: lead.pipeline.toString(),
                  currency: lead.currency.toString(),
                  leadValue: lead.leadValue.toString(),
                  companyName: lead.companyName.toString(),
                  firstName: lead.firstName.toString(),
                  lastName: lead.lastName.toString(),
                  phoneCode: lead.phoneCode.toString(),
                  telephone: lead.telephone.toString(),
                  email: lead.email.toString(),
                  address: lead.address.toString(),
                  leadMembers: lead.leadMembers.toString(),
                  source: lead.source.toString(),
                  category: lead.category.toString(),
                  files: lead.files.toString(),
                  status: lead.status.toString(),
                  interestLevel: lead.interestLevel.toString(),
                  leadScore: lead.leadScore.toString(),
                  isConverted: lead.isConverted.toString(),
                  clientId: lead.clientId.toString(),
                  createdBy: lead.createdBy.toString(),
                  updatedBy: lead.updatedBy.toString(),
                  createdAt: formattedDate.toString(),
                  updatedAt: lead.updatedAt.toString(),
                  onTap:
                      () =>
                          (lead.id != null)
                              ? Get.to(
                                () => LeadDetailsScreen(id: lead.id!),
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
