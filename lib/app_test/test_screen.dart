import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(height: 20), CrmIcon(iconPath: ICRes.mention)],
          ),
        ),
      ),
    );
  }
}
