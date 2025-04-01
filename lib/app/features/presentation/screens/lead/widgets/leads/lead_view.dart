import 'package:crm_flutter/app/features/data/lead/lead_home/lead_controller.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/widgets/leads/lead_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../screens/lead_overview/lead_overview_screen.dart';


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
                  final lead = controller.leadsList[i];

                  String formattedDate = DateFormat('dd MMM yyyy').format(
                    DateTime.parse(lead.createdAt ?? DateTime.now().toString()),
                  );

                  return GestureDetector(
                    onTap: () {
                      if (lead.id != null) {
                        Get.to(() => LeadOverviewScreen(leadId: lead.id!));
                      } else {
                        Get.snackbar('Error', 'Lead ID is missing');
                      }
                    },
                    child: LeadTile(
                      claint_name: lead.firstName ?? "No name",
                      company_name: lead.leadTitle ?? "No name",
                      amount: lead.leadValue ?? "0",
                      source: lead.source ?? "Unknown",
                      status: "Good",
                      status_color: Colors.green,
                      date: formattedDate,
                    ),
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
