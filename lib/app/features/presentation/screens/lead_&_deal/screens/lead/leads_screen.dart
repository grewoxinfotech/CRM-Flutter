import 'package:crm_flutter/app/features/data/lead/lead_home/lead_controller.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/lead/lead_detail_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/lead_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadsScreen extends StatelessWidget {
  LeadsScreen({super.key});

  LeadController controller = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: CrmHeadline(title: "Leads"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        ()=> ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemCount: controller.leadsList.length,
          separatorBuilder: (context, s) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final lead = controller.leadsList[i];

            String formattedDate = DateFormat(
              'dd MMM yyyy',
            ).format(DateTime.parse(lead.createdAt ?? DateTime.now().toString()));
            return LeadTile(
              claint_name: lead.firstName ?? "No name",
              company_name: lead.leadTitle ?? "No name",
              amount: lead.leadValue ?? "0",
              source: lead.source ?? "Unknown",
              status: "Good",
              status_color: Colors.green,
              date: formattedDate,
              onTap:
                  () =>
                      (lead.id != null)
                          ? Get.to(() => LeadDetailsScreen(leadId: lead.id!))
                          : Get.snackbar('Error', 'Lead ID is missing'),
            );
          },
        ),
      ),
    );
  }
}
