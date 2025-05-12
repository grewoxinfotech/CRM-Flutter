import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/widgets/lead_overview_card.dart';
import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadDetailScreen extends StatelessWidget {
  const LeadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    Get.lazyPut<LeadController>(() => LeadController());
    final leadController = Get.find<LeadController>();
    final LeadModel data = Get.arguments;

    List widgets = [
      LeadOverviewCard(
        id: data.id.toString(),
        color: Colors.green,
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
        leadMembers: data.leadMembers.length,
        source: data.source.toString(),
        category: data.category.toString(),
        files: data.files.toString(),
        status: data.status.toString(),
        interestLevel: data.interestLevel.toString(),
        leadScore: data.leadScore.toString(),
        isConverted: data.isConverted.toString(),
        clientId: data.clientId.toString(),
        createdBy: data.createdBy.toString(),
        updatedBy: data.updatedBy.toString(),
        createdAt: data.createdAt.toString(),
        updatedAt: data.updatedAt.toString(),
        onDelete:
            () => CrmDeleteDialog(
              onConfirm: () {
                leadController.deleteLead(data.id.toString());
                Get.back();
              },
            ),
        onEdit: () {},
      ),
      ViewScreen(
        itemCount: data.files.length,
        padding: const EdgeInsets.all(AppPadding.medium),

        itemBuilder: (context, i) {
          final file = data.files[i];
          return FileCard(
            url: file.url,
            name: file.filename,
            id: file.filename,
            role: "File",
            onTap: null,
            onDelete: null,
          );
        },
      ),
      // ViewScreen(
      //     itemCount: leadMembers.length,
      //     itemBuilder: (context, index) {
      //       final member = leadMembers[index];
      //       final rolesService = Get.find<RolesService>();
      //       final roleName = rolesService.getRoleNameById(member.roleId ?? '');
      //       final role = [
      //         if (roleName.isNotEmpty) roleName,
      //         if (member.designation?.isNotEmpty == true) member.designation,
      //         if (member.department?.isNotEmpty == true) member.department,
      //       ].where((s) => s != null && s.isNotEmpty).join(' - ');
      //
      //       return MemberCard(
      //         title: member.username ?? 'Unknown User',
      //         subTitle: role.isNotEmpty ? role : 'No Role',
      //         role: member.email ?? 'No Email',
      //         onTap: null,
      //       );
      //     }),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
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
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return PaymentCard();
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Lead"),
        leading: CrmBackButton(),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Files"),
            TabBarModel(iconPath: ICRes.attach, label: "Members"),
            TabBarModel(iconPath: ICRes.attach, label: "Notes"),
          ],
        ),
      ),
      body: PageView.builder(
        itemCount: widgets.length,
        controller: tabBarController.pageController,
        onPageChanged: tabBarController.onPageChanged,
        itemBuilder: (context, i) {
          return widgets[i];
        },
      ),
    );
  }
}
