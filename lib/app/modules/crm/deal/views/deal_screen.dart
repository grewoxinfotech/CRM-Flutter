import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_add_screen.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_detail_screen.dart';
import 'package:crm_flutter/app/modules/crm/deal/widget/deal_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealsScreen extends StatelessWidget {
  DealsScreen({super.key});

  DealController dealController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      floatingActionButton: CrmButton(
        title: "Add Deal",
        onTap: () => Get.to(DealAddScreen()),
      ),
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: Text("Deals"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(future: dealController.getDeals(), builder: (context , snapshot) {
        if (snapshot.hasData){
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No data"),);
          }
          else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(horizontal: 15),
              separatorBuilder: (context, s) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final deal = dealController.deal[i];

                String formattedDate = DateFormat('dd MMM yyyy').format(
                  DateTime.parse(
                    deal.createdAt.toString() ?? DateTime.now().toString(),
                  ),
                );
                return DealCard(
                  id: (deal.id.toString().isEmpty) ? "N/A" : deal.id.toString(),
                  color: Get.theme.colorScheme.error,
                  dealTitle:
                  (deal.dealTitle.toString().isEmpty)
                      ? "N/A"
                      : deal.dealTitle.toString(),
                  currency:
                  (deal.currency.toString().isEmpty)
                      ? "N/A"
                      : deal.currency.toString(),
                  value:
                  (deal.value.toString().isEmpty)
                      ? "N/A"
                      : deal.value.toString(),
                  pipeline:
                  (deal.pipeline.toString().isEmpty)
                      ? "N/A"
                      : deal.pipeline.toString(),
                  stage:
                  (deal.stage.toString().isEmpty)
                      ? "N/A"
                      : deal.stage.toString(),
                  status:
                  (deal.status.toString().isEmpty)
                      ? "N/A"
                      : deal.status.toString(),
                  label:
                  (deal.label.toString().isEmpty)
                      ? "N/A"
                      : deal.label.toString(),
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
                  email:
                  (deal.email.toString().isEmpty)
                      ? "N/A"
                      : deal.email.toString(),
                  phone:
                  (deal.phone.toString().isEmpty)
                      ? "N/A"
                      : deal.phone.toString(),
                  source:
                  (deal.source.toString().isEmpty)
                      ? "N/A"
                      : deal.source.toString(),
                  companyName:
                  (deal.companyName.toString().isEmpty)
                      ? "N/A"
                      : deal.companyName.toString(),
                  website:
                  (deal.website.toString().isEmpty)
                      ? "N/A"
                      : deal.website.toString(),
                  address:
                  (deal.address.toString().isEmpty)
                      ? "N/A"
                      : deal.address.toString(),
                  files:
                  (deal.files.toString().isEmpty)
                      ? "N/A"
                      : deal.files.toString(),
                  assignedTo:
                  (deal.assignedTo.toString().isEmpty)
                      ? "N/A"
                      : deal.assignedTo.toString(),
                  clientId:
                  (deal.clientId.toString().isEmpty)
                      ? "N/A"
                      : deal.clientId.toString(),
                  isWon:
                  (deal.isWon.toString().isEmpty)
                      ? "N/A"
                      : deal.isWon.toString(),
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
                  createdAt: formattedDate,

                  updatedAt:
                  (deal.updatedAt.toString().isEmpty)
                      ? "N/A"
                      : deal.updatedAt.toString(),
                  onTap:
                      () =>
                  (deal.id != null)
                      ? Get.to(() => DealDetailScreen(id: deal.id!))
                      : Get.snackbar('Error', 'deal ID is missing'),
                  onDelete: () {},
                  onEdit: () {},
                );
              },
            );
          }
        }
        else {
          return CrmLoadingCircle();
        }
      })
    );
  }
}
