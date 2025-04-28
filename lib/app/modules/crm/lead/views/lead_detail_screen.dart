import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/crm/lead/lead_model.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/widgets/lead_overview_card.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/file_tile.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_tile.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_tile.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_tile.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/screens/view_model.dart';
import 'package:crm_flutter/app/widgets/tab_bar/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadDetailScreen extends StatelessWidget {
  final String id;

  const LeadDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController controller = Get.find();
    LeadController leadController = Get.put(LeadController());
    // if (leadController.isLoading.value) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (leadController.lead.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final lead = leadController.lead.firstWhere(
      (lead) => lead.id == id,
      orElse: () => LeadModel(),
    );

    if (lead.id == null) {
      return const Center(child: Text("Lead not found"));
    }
    List widgets = [
      LeadOverviewCard(
        id: lead.id.toString().isEmpty ? "N/A" : lead.id.toString(),
        inquiryId:
            lead.inquiryId.toString().isEmpty
                ? "N/A"
                : lead.inquiryId.toString(),
        leadTitle:
            lead.leadTitle.toString().isEmpty
                ? "N/A"
                : lead.leadTitle.toString(),
        leadStage:
            lead.leadStage.toString().isEmpty
                ? "N/A"
                : lead.leadStage.toString(),
        pipeline:
            lead.pipeline.toString().isEmpty ? "N/A" : lead.pipeline.toString(),
        currency:
            lead.currency.toString().isEmpty ? "N/A" : lead.currency.toString(),
        leadValue:
            lead.leadValue.toString().isEmpty
                ? "N/A"
                : lead.leadValue.toString(),
        companyName:
            lead.companyName.toString().isEmpty
                ? "N/A"
                : lead.companyName.toString(),
        firstName:
            lead.firstName.toString().isEmpty
                ? "N/A"
                : lead.firstName.toString(),
        lastName:
            lead.lastName.toString().isEmpty ? "N/A" : lead.lastName.toString(),
        phoneCode:
            lead.phoneCode.toString().isEmpty
                ? "N/A"
                : lead.phoneCode.toString(),
        telephone:
            lead.telephone.toString().isEmpty
                ? "N/A"
                : lead.telephone.toString(),
        email: lead.email.toString().isEmpty ? "N/A" : lead.email.toString(),
        address:
            lead.address.toString().isEmpty ? "N/A" : lead.address.toString(),
        leadMembers:
            lead.leadMembers.toString().isEmpty
                ? "N/A"
                : lead.leadMembers.toString(),
        source: lead.source.toString().isEmpty ? "N/A" : lead.source.toString(),
        category:
            lead.category.toString().isEmpty ? "N/A" : lead.category.toString(),
        files: lead.files.toString().isEmpty ? "N/A" : lead.files.toString(),
        status: lead.status.toString().isEmpty ? "N/A" : lead.status.toString(),
        interestLevel:
            lead.interestLevel.toString().isEmpty
                ? "N/A"
                : lead.interestLevel.toString(),
        leadScore:
            lead.leadScore.toString().isEmpty
                ? "N/A"
                : lead.leadScore.toString(),
        isConverted:
            lead.isConverted.toString().isEmpty
                ? "N/A"
                : lead.isConverted.toString(),
        clientId:
            lead.clientId.toString().isEmpty ? "N/A" : lead.clientId.toString(),
        createdBy:
            lead.createdBy.toString().isEmpty
                ? "N/A"
                : lead.createdBy.toString(),
        updatedBy:
            lead.updatedBy.toString().isEmpty
                ? "N/A"
                : lead.updatedBy.toString(),
        createdAt:
            lead.createdAt.toString().isEmpty
                ? "N/A"
                : lead.createdAt.toString(),
        updatedAt:
            lead.updatedAt.toString().isEmpty
                ? "N/A"
                : lead.updatedAt.toString(),
        onDelete: () => CrmDeleteDialog(),
        onEdit: () {},
      ),
      ViewModel(
        itemCount: 10,
        itemBuilder: (context, i) {
          return FileTile();
        },
      ),
      ViewModel(
        itemCount: 10,
        itemBuilder: (context, i) {
          return NoteTile(
            id: "id",
            relatedId: "relatedId",
            noteTitle: "noteTitle",
            noteType: "noteType",
            employees: "employees",
            description: "description",
            clientId: "clientId",
            createdBy: "createdBy",
            updatedBy: "updatedBy",
            createdAt: "createdAt",
            updatedAt: "updatedAt",
          );
        },
      ),
      ViewModel(
        itemCount: 10,
        itemBuilder: (context, i) {
          return MemberTile();
        },
      ),
      ViewModel(
        itemCount: 10,
        itemBuilder: (context, i) {
          return PaymentTile();
        },
      ),
    ];
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        title: Text("Lead"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: PageView.builder(
                  itemCount: widgets.length,
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = i;
                      },
                      child: widgets[i],
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 5),
              CrmTabBar(
                items: [
                  TabItem(iconPath: ICRes.attach, label: "Overview"),
                  TabItem(iconPath: ICRes.attach, label: "Files"),
                  TabItem(iconPath: ICRes.attach, label: "Members"),
                  TabItem(iconPath: ICRes.attach, label: "Notes"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
