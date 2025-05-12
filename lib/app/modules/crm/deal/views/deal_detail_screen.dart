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
import 'package:crm_flutter/app/widgets/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealDetailScreen extends StatelessWidget {
  const DealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TabBarController tabBarController = Get.put(TabBarController());
    Get.lazyPut<DealController>(() => DealController());
    final DealController dealController = Get.find();

    final DealModel data = Get.arguments;

    List widgets = [
      DealOverviewCard(
        color: Colors.blue,
        id: data.id.toString(),
        dealTitle: data.dealTitle.toString(),
        currency: data.currency.toString(),
        value: data.value.toString(),
        pipeline: data.pipeline.toString(),
        stage: data.stage.toString(),
        status: data.status.toString(),
        label: data.label.toString(),
        closedDate: data.closedDate.toString(),
        firstName: data.firstName.toString(),
        lastName: data.lastName.toString(),
        email: data.email.toString(),
        phone: data.phone.toString(),
        source: data.source.toString(),
        companyName: data.companyName.toString(),
        website: data.website.toString(),
        address: data.address.toString(),
        products: data.products.toString(),
        files: data.files.toString(),
        assignedTo: data.assignedTo.toString(),
        clientId: data.clientId.toString(),
        isWon: data.isWon.toString(),
        companyId: data.companyId.toString(),
        contactId: data.contactId.toString(),
        createdBy: data.createdBy.toString(),
        updatedBy: data.updatedBy.toString(),
        createdAt: data.createdAt.toString(),
        updatedAt: data.updatedAt.toString(),
        onDelete:
            () => CrmDeleteDialog(
              entityType: data.dealTitle.toString(),
              onConfirm: () => dealController.deleteDeal(data.id.toString()),
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
