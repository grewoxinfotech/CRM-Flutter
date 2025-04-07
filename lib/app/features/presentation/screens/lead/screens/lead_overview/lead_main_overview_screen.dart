import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/features/lead_main_overview_model_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadMainOverviewScreen extends StatelessWidget {
  LeadMainOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Lead",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.surface,
      ),
      resizeToAvoidBottomInset: true,
      body: LeadMainOverviewModelView(),
    );
  }
}
