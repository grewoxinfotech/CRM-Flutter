import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/deals/views/deal_add_screen.dart';
import 'package:crm_flutter/app/modules/deals/views/deal_detail_screen.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/deal_tile.dart';
import 'package:crm_flutter/app/modules/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealsScreen extends StatelessWidget {
  DealsScreen({super.key});

  DealController dealController = Get.put(DealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      floatingActionButton:
      (dealController.dealsList.length != 0)
          ? CrmButton(
        title: "Add Lead",
        onTap: () {
          print("add leads");
        },
      )
          : null,
      appBar: AppBar(
        title: CrmHeadline(title: "Deals"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (dealController.isLoading.value == false) {
          if (dealController.dealsList.length <= 0) {
            return Center(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CrmIc(
                          iconPath: ICRes.leads,
                          width: 50,
                          color: Get.theme.colorScheme.onSecondary,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Deals Found!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Get.theme.colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 80),
                    alignment: Alignment.bottomCenter,
                    child: CrmButton(
                      title: "Add Deal",
                      onTap: () => Get.to(DealAddScreen()),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: dealController.dealsList.length,
              separatorBuilder: (context, s) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final deal = dealController.dealsList[i];

                String formattedDate = DateFormat('dd MMM yyyy').format(
                  DateTime.parse(
                    deal.createdAt.toString() ?? DateTime.now().toString(),
                  ),
                );
                return DealTile(
                  claint_name: deal.dealName ?? "No name",
                  company_name: deal.leadTitle ?? "No name",
                  amount: deal.updatedBy ?? "0",
                  source: deal.stage ?? "Unknown",
                  status: "Good",
                  status_color: Colors.red,
                  date: formattedDate,
                  onTap:
                      () =>
                  (deal.id != null)
                      ? Get.to(
                        () => DealDetailScreen(dealId: deal.id!),
                  )
                      : Get.snackbar('Error', 'deal ID is missing'),
                );
              },
            );
          }
        } else {
          return CrmLoadingCircle();
        }
      }),
    );
  }
}
