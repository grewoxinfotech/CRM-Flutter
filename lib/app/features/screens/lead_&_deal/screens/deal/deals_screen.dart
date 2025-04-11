import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/deal/deal_controller.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/screens/deal/deal_add_screen.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/screens/deal/deal_details_Screen.dart';
import 'package:crm_flutter/app/features/screens/lead_&_deal/widgets/deal_tile.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_headline.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/widgets/crm_loading_circle.dart';
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
                        CrmIcon(
                          iconPath: ICRes.leads,
                          width: 50,
                          color: COLORRes.TEXT_SECONDARY.withAlpha(100),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Deals Found!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: COLORRes.TEXT_SECONDARY.withAlpha(100),
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
                                () => DealDetailsScreen(dealId: deal.id!),
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
