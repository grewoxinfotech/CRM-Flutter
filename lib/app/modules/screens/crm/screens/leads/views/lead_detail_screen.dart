import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_overview_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadDetailScreen extends StatelessWidget {
  const LeadDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lead = Get.arguments as LeadModel;
    final tabBarController = Get.put(TabBarController());

    List<Widget> widgets = [
      LeadOverviewCard(lead: lead),
      // ViewScreen(
      //   itemCount: lead.files!.length,
      //   padding: const EdgeInsets.all(AppPadding.medium),
      //
      //   itemBuilder: (context, i) {
      //     final file = lead.files![i];
      //     return FileCard(
      //       url: file.url,
      //       name: file.filename,
      //       id: file.filename,
      //       role: "File",
      //       onTap: null,
      //       onDelete: null,
      //     );
      //   },
      // ),
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
            TabBarModel(iconPath: Ic.attach, label: "Overview"),
            TabBarModel(iconPath: Ic.attach, label: "Files"),
            TabBarModel(iconPath: Ic.attach, label: "Members"),
            TabBarModel(iconPath: Ic.attach, label: "Notes"),
          ],
        ),
      ),
      body: PageView(
        controller: tabBarController.pageController,
        onPageChanged: tabBarController.onPageChanged,
        children: widgets,
      ),
    );
  }
}
