import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/crm/lead/lead_model.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/widgets/lead_overview_card.dart';
import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'package:crm_flutter/app/widgets/tab_bar/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadDetailScreen extends StatelessWidget {
  final String id;

  const LeadDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController controller = Get.put(CrmTabBarController());
    LeadController leadController = Get.find();
    // if (leadController.isLoading.value) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (leadController.leads.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final lead = leadController.leads.firstWhere(
      (lead) => lead.id == id,
      orElse: () => LeadModel(),
    );
    
    if (lead.id == null) {
      return const Center(child: Text("Lead not found"));
    }
    List widgets = [
      LeadOverviewCard(
        id: lead.id.toString(),
        color: Colors.green,
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
        createdAt: lead.createdAt.toString(),
        updatedAt: lead.updatedAt.toString(),
        onDelete: () => CrmDeleteDialog(
            onConfirm: (){
              leadController.deleteLead(lead.id.toString());
              Get.back();
            },
          ),
        onEdit: () {},
      ),
      ViewScreen(
        itemCount: 10,
        itemBuilder: (context, i) {
          return FileCard(
            url:
                "https://images.pexels.com/photos/31300173/pexels-photo-31300173/free-photo-of-vibrant-blue-poison-dart-frog-on-leaf.jpeg?auto=compress&cs=tinysrgb&w=600",
            name: "Mandok ${i + 1}",
            id: "Bilu mandok",
            role: "ANM",
            onTap: () => print((i + 1).toString()),
            onDelete: () => print("Delete file : ${i + 1}"),
          );
        },
      ),
      ViewScreen(
        itemCount: 10,
        itemBuilder: (context, i) {
          return MemberCard(subTitle: "Boss partner", title: "Jay Kumar",role: "HR",);
        },
      ),
      ViewScreen(
        itemCount: 10,
        itemBuilder: (context, i) {
          return NoteCard(
            id: "sdsidhuspduhspfuhpfu",
            relatedId: "smiugvhoidnyhuhg",
            noteTitle: "Call Ms. tejas",
            noteType: "Call",
            description: "Bhala mori rama bhala tari rama",
            clientId: "jsdctfbutyftrcutyusytfty",
            createdBy: "createdBy",
            updatedBy: "updatedBy",
            createdAt: "02 05 2025",
            updatedAt: "updatedAt",
          );
        },
      ),
      ViewScreen(
        itemCount: 10,
        itemBuilder: (context, i) {
          return PaymentCard();
        },
      ),
    ];



    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: Text("Lead"),
        leading: CrmBackButton(),
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
