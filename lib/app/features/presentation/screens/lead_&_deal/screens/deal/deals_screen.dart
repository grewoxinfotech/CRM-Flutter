import 'package:crm_flutter/app/features/data/deal/deal_controller.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/deal/deal_details_Screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/deal_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DealsScreen extends StatelessWidget {
  DealsScreen({super.key});

  DealController controller = Get.put(DealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: CrmHeadline(title: "Deals"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: controller.dealsList.length,
        separatorBuilder: (context, s) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final deal = controller.dealsList[i];

          String formattedDate = DateFormat(
            'dd MMM yyyy',
          ).format(DateTime.parse(deal.createdAt ?? DateTime.now().toString()));
          return DealTile(
            claint_name: deal.dealName ?? "No name",
            company_name: deal.dealTitle ?? "No name",
            amount: deal.updatedBy ?? "0",
            source: deal.stage ?? "Unknown",
            status: "Good",
            status_color: Colors.red,
            date: formattedDate,
            onTap:
                () =>
                    (deal.id != null)
                        ? Get.to(() => DealDetailsScreen(dealId: deal.id!))
                        : Get.snackbar('Error', 'deal ID is missing'),
          );
        },
      ),
    );
  }
}
