import 'package:crm_flutter/app/data/network/all/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadController());

    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Leads")),
      body: FutureBuilder(
        future: controller.getLeads(),
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
            final leads = controller.leads;
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No Leads"));
            } else {
              return ListView.builder(
                itemBuilder: (context, i) {
                  return LeadCard();
                },
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
