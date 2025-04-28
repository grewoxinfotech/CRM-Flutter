import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/crm/deal/deal_model.dart';
import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/deal/widget/deal_overview_card.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/note_tile.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/screens/view_model.dart';
import 'package:crm_flutter/app/widgets/tab_bar/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealDetailScreen extends StatelessWidget {
  final id;

  const DealDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController controller = Get.put(CrmTabBarController());
    DealController dealController = Get.put(DealController());
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
        id: (deal.id.toString().isEmpty) ? "N/A" : deal.id.toString(),
        dealTitle:
            (deal.dealTitle.toString().isEmpty)
                ? "N/A"
                : deal.dealTitle.toString(),
        currency:
            (deal.currency.toString().isEmpty)
                ? "N/A"
                : deal.currency.toString(),
        value: (deal.value.toString().isEmpty) ? "N/A" : deal.value.toString(),
        pipeline:
            (deal.pipeline.toString().isEmpty)
                ? "N/A"
                : deal.pipeline.toString(),
        stage: (deal.stage.toString().isEmpty) ? "N/A" : deal.stage.toString(),
        status:
            (deal.status.toString().isEmpty) ? "N/A" : deal.status.toString(),
        label: (deal.label.toString().isEmpty) ? "N/A" : deal.label.toString(),
        closedDate:
            (deal.closedDate.toString().isEmpty)
                ? "N/A"
                : deal.closedDate.toString(),
        firstName:
            (deal.firstName.toString().isEmpty)
                ? "N/A"
                : deal.firstName.toString(),
        lastName:
            (deal.lastName.toString().isEmpty)
                ? "N/A"
                : deal.lastName.toString(),
        email: (deal.email.toString().isEmpty) ? "N/A" : deal.email.toString(),
        phone: (deal.phone.toString().isEmpty) ? "N/A" : deal.phone.toString(),
        source:
            (deal.source.toString().isEmpty) ? "N/A" : deal.source.toString(),
        companyName:
            (deal.companyName.toString().isEmpty)
                ? "N/A"
                : deal.companyName.toString(),
        website:
            (deal.website.toString().isEmpty) ? "N/A" : deal.website.toString(),
        address:
            (deal.address.toString().isEmpty) ? "N/A" : deal.address.toString(),
        files: (deal.files.toString().isEmpty) ? "N/A" : deal.files.toString(),
        assignedTo:
            (deal.assignedTo.toString().isEmpty)
                ? "N/A"
                : deal.assignedTo.toString(),
        clientId:
            (deal.clientId.toString().isEmpty)
                ? "N/A"
                : deal.clientId.toString(),
        isWon: (deal.isWon.toString().isEmpty) ? "N/A" : deal.isWon.toString(),
        companyId:
            (deal.companyId.toString().isEmpty)
                ? "N/A"
                : deal.companyId.toString(),
        contactId:
            (deal.contactId.toString().isEmpty)
                ? "N/A"
                : deal.contactId.toString(),
        createdBy:
            (deal.createdBy.toString().isEmpty)
                ? "N/A"
                : deal.createdBy.toString(),
        updatedBy:
            (deal.updatedBy.toString().isEmpty)
                ? "N/A"
                : deal.updatedBy.toString(),
        createdAt:
            (deal.createdAt.toString().isEmpty)
                ? "N/A"
                : deal.createdAt.toString(),
        updatedAt:
            (deal.updatedAt.toString().isEmpty)
                ? "N/A"
                : deal.updatedAt.toString(),
        onDelete:
            () => CrmDeleteDialog(
              entityType: deal.dealTitle.toString(),
              onConfirm: () => dealController.deleteDeal(id),
            ),
      ),
      ViewModel(
        itemCount: 24,
        itemBuilder: (context, i) {
          return NoteTile(
            id: "notes data",
            relatedId: "notes data",
            noteTitle: "notes data",
            noteType: "notes data",
            employees: "notes data",
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
    ];
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        title: Text("Deal"),
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
                  TabItem(iconPath: ICRes.attach, label: "Members"),
                  TabItem(iconPath: ICRes.attach, label: "Notes"),
                  TabItem(iconPath: ICRes.attach, label: "Files"),
                  TabItem(iconPath: ICRes.attach, label: "Invoice"),
                  TabItem(iconPath: ICRes.attach, label: "Paymant"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
