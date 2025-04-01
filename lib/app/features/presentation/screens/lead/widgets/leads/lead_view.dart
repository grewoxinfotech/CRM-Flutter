import 'package:crm_flutter/app/features/data/lead/lead_controller.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/widgets/leads/lead_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class LeadView extends StatelessWidget {
  const LeadView({super.key});

  @override
  Widget build(BuildContext context) {

    LeadController controller = Get.put(LeadController());

    return SingleChildScrollView(
      child: Column(
        children: [
          CrmHeadline(
            title: "Leads",
            padding: const EdgeInsets.symmetric(horizontal: 30),
            showViewAll: true,
            showtext: "All Filters",
          ),
          const SizedBox(height: 10),
          Obx(
                  ()=> SizedBox(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.leadsList.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  String formatDate(String dateString) {
                    DateTime dateTime = DateTime.parse(dateString); // Convert to DateTime
                    return DateFormat('dd MMM yyyy').format(dateTime); // Format as "29 Mar 2025"
                  }
                  String formattedDate = formatDate(controller.leadsList[i].createdAt.toString());
                  return LeadTile(
                    claint_name: controller.leadsList[i].firstName ?? "No name",
                    company_name: controller.leadsList[i].leadTitle ?? "No name",
                    amount: i, // or any logic for amount
                    source: controller.leadsList[i].source.toString(),
                    status: "Good",
                    status_color: Colors.green,
                    date: formattedDate.toString(),
                  );
                },
                separatorBuilder: (context, i) => const SizedBox(height: 10),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
