import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/features/lead_overview_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewScreen extends StatelessWidget {

  final String leadId;

  LeadOverviewScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CrmAppBar(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(0),
        child: CrmBottomNavigationBar(),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LeadOverviewModelView(leadId: leadId),
      ),
    );
  }
}