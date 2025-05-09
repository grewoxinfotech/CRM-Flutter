import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_add_screen.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_detail_screen.dart';
import 'package:crm_flutter/app/modules/crm/deal/widget/deal_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealScreen extends StatelessWidget {


  DealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<DealController>(() => DealController());
    final DealController dealController = Get.find<DealController>();
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Deals"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: CrmButton(
        title: "Add Deal",
        onTap: () => Get.to(DealAddScreen()),
      ),
      body: FutureBuilder(
        future: dealController.getDeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error : \n${snapshot.error}',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final deals = dealController.deal;
            if (deals.isEmpty) {
              return const Center(child: Text("No deals available."));
            } else {
              return Obx(
                () => ViewScreen(
                  itemCount: deals.length,
                  itemBuilder: (context, i) {
                    final data = deals[i];
                    return DealCard(
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
                      createdBy: formatDate(data.createdBy.toString()),
                      updatedBy: formatDate(data.updatedBy.toString()),
                      createdAt: formatDate(data.createdAt.toString()),
                      updatedAt: formatDate(data.updatedAt.toString()),
                      color: Get.theme.colorScheme.error,
                      onTap: () => (data.id != null)
                          ? Get.to(() => DealDetailScreen(id: data.id!))
                          : Get.snackbar('Error', 'deal ID is missing'),
                      onEdit: () {},
                      onDelete: () {},
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
