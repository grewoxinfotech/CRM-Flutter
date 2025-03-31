import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_id_information_2.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LeadOverviewIdInformation2()],
          ),
        ),
      ),
    );
  }
}
