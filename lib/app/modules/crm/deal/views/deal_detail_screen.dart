import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/deal/widget/deal_overview_card.dart';
import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/modules/project/invoice/widget/invoice_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/modules/crm/notes/views/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealDetailScreen extends StatelessWidget {
  final id;

  const DealDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    TabBarController tabBarController = Get.put(TabBarController());
    Get.lazyPut<DealController>(() => DealController());
    final DealController dealController = Get.find();
    if (dealController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (dealController.deal.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final deal = dealController.deal.firstWhere(
      (deal) => deal.id == id,
      orElse: () => DealModel(),
    );

    if (deal.id == null) {
      return const Center(child: Text("Lead not found"));
    }
    List widgets = [
      DealOverviewCard(
        color: Colors.blue,
        id: deal.id.toString(),
        dealTitle: deal.dealTitle.toString(),
        currency: deal.currency.toString(),
        value: deal.value.toString(),
        pipeline: deal.pipeline.toString(),
        stage: deal.stage.toString(),
        status: deal.status.toString(),
        label: deal.label.toString(),
        closedDate: deal.closedDate.toString(),
        firstName: deal.firstName.toString(),
        lastName: deal.lastName.toString(),
        email: deal.email.toString(),
        phone: deal.phone.toString(),
        source: deal.source.toString(),
        companyName: deal.companyName.toString(),
        website: deal.website.toString(),
        address: deal.address.toString(),
        products: deal.products.toString(),
        files: deal.files.toString(),
        assignedTo: deal.assignedTo.toString(),
        clientId: deal.clientId.toString(),
        isWon: deal.isWon.toString(),
        companyId: deal.companyId.toString(),
        contactId: deal.contactId.toString(),
        createdBy: deal.createdBy.toString(),
        updatedBy: deal.updatedBy.toString(),
        createdAt: deal.createdAt.toString(),
        updatedAt: deal.updatedAt.toString(),
        onDelete:
            () => CrmDeleteDialog(
              entityType: deal.dealTitle.toString(),
              onConfirm: () => dealController.deleteDeal(id),
            ),
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return MemberCard(title: "Hero");
        },
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return NoteCard(
            id: "notes data",
            relatedId: "notes data",
            noteTitle: "notes data",
            noteType: "notes data",
            description: "notes data",
            clientId: "notes data",
            createdBy: "notes data",
            updatedBy: "notes data",
            createdAt: "notes data",
            updatedAt: "notes data",
            onTap: () {},
            onDelete: () {},
            onEdit: () {},
          );
        },
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return FileCard(
            url:
                "https://images.pexels.com/photos/31300173/pexels-photo-31300173/free-photo-of-vibrant-blue-poison-dart-frog-on-leaf.jpeg?auto=compress&cs=tinysrgb&w=600",
            id: "id",
            name: "name",
            role: "role",
            description: "description",
            file: "file",
            clientId: "clientId",
            createdBy: "createdBy",
            updatedBy: "updatedBy",
            createdAt: "createdAt",
            updatedAt: "updatedAt",
          );
        },
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return InvoiceCard(
            id: "id",
            inquiryId: "inquiryId",
            leadTitle: "leadTitle",
            leadStage: "leadStage",
            pipeline: "pipeline",
            currency: 'R.',
            leadValue: "1000000",
            companyName: "companyName",
            firstName: "firstName",
            lastName: "lastName",
            phoneCode: "phoneCode",
            telephone: "telephone",
            email: "email",
            address: "address",
            leadMembers: "leadMembers",
            source: "source",
            category: "category",
            files: "files",
            status: "status",
            interestLevel: "interestLevel",
            leadScore: "leadScore",
            isConverted: "isConverted",
            clientId: "clientId",
            createdBy: "createdBy",
            updatedBy: "updatedBy",
            createdAt: "createdAt",
            updatedAt: "updatedAt",
          );
        },
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return PaymentCard(
            id: "id",
            project: "Project",
            startDate: "startDate",
            endDate: "endDate",
            projectMembers: "projectMembers",
            completion: "completion",
            status: "status",
            clientId: "clientId",
            createdBy: "createdBy",
            createdAt: "createdAt",
            updatedAt: "updatedAt",
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Deal"),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Members"),
            TabBarModel(iconPath: ICRes.attach, label: "Notes"),
            TabBarModel(iconPath: ICRes.attach, label: "Files"),
            TabBarModel(iconPath: ICRes.attach, label: "Invoice"),
            TabBarModel(iconPath: ICRes.attach, label: "Payment"),
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
