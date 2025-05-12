import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_add_screen.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/crm/lead/widgets/lead_card.dart';
import 'package:crm_flutter/app/modules/crm/lead/bindings/lead_binding.dart';
import 'package:crm_flutter/app/data/network/role/service/roles_service.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    Get.lazyPut<LeadController>(() => LeadController());
    final controller = Get.find<LeadController>();
    
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Leads")),

      floatingActionButton: CrmButton(
        title: "Add Lead",
        onTap: () async {
          await Get.to(() => const LeadAddScreen());
          // Refresh data when returning from add screen
          controller.refreshData();
        },
      ),
      body: FutureBuilder(
        future: controller.refreshData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(  
                width: 250,   
                child: Text(
                  'Server Error : \n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            return Obx(
              () {
                final leads = controller.leads;
                if (leads.isEmpty) {
                  return const Center(child: Text("No leads available."));
                }
                
                return ViewScreen(
                  itemCount: leads.length,
                  itemBuilder: (context, i) {
                    final data = leads[i];
                    return LeadCard(
                      color: Colors.green,
                      id: data.id.toString(),
                      inquiryId: data.inquiryId.toString(),
                      leadTitle: data.leadTitle.toString(),
                      leadStage: data.leadStage.toString(),
                      pipeline: data.pipeline.toString(),
                      currency: data.currency.toString(),
                      leadValue: data.leadValue.toString(),
                      companyName: data.companyName.toString(),
                      firstName: data.firstName.toString(),
                      lastName: data.lastName.toString(),
                      phoneCode: data.phoneCode.toString(),
                      telephone: data.telephone.toString(),
                      email: data.email.toString(),
                      address: data.address.toString(),
                      leadMembers: data.leadMembers.toString(),
                      source: data.source.toString(),
                      category: data.category.toString(),
                      files: data.files.toString(),
                      status: data.status.toString(),
                      interestLevel: data.interestLevel.toString(),
                      leadScore: data.leadScore.toString(),
                      isConverted: data.isConverted.toString(),
                      clientId: data.clientId.toString(),
                      createdBy: formatDate(data.createdBy.toString()),
                      updatedBy: formatDate(data.updatedBy.toString()),
                      createdAt: formatDate(data.createdAt.toString()),
                      updatedAt: formatDate(data.updatedAt.toString()),
                      onTap: () async {
                        if (data.id != null) {
                          await Get.to(
                            () => LeadDetailScreen(id: data.id!),
                            binding: LeadBinding(),
                          );
                          // Refresh data 
                          controller.refreshData();
                        } else {
                          Get.snackbar('Error', 'Lead ID is missing');
                        }
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
