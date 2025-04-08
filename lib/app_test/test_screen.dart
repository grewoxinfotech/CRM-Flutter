import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/activity_tile.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/invoice_tile.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/member_tile.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/widgets/payment_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ActivityTile(),]
          ),
        ),
      ),
    );
  }
}
