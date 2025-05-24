import 'package:crm_flutter/app/modules/screens/crm/screens/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/widget/deal_list.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealScreen extends StatelessWidget {
  DealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DealController dealController = Get.put(DealController());
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Deals"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: CrmButton(
        title: "Add Deal",
        onTap: () => Get.toNamed(AppRoutes.dealAdd),
      ),
      body: DealList(),
    );
  }
}
