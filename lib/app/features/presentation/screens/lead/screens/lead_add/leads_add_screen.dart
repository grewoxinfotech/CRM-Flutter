import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/features/lead_add_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/features/lead_add_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadsAddScreen extends StatelessWidget {
  const LeadsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadAddModelView> widgets = [];
    widgets = LeadAddModelView.getWidgets();
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(70
      ), child: CrmAppBar()),
      backgroundColor: Get.theme.colorScheme.background,
      body: const LeadAddModelWidget(),
    );
  }
}
