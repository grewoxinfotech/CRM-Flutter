import 'package:crm_flutter/app/modules/screens/crm/screens/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_list.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadController());

    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Leads")),
      body: LeadList(),
    );
  }
}
