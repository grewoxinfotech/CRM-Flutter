

import 'package:crm_flutter/features/data/resources/icon_resources.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/attendance/attendance_widget.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/functionalities/widget/functions_box.dart';
import 'package:crm_flutter/features/presentation/widgets/widget/functionalities/functionalities_widgets.dart';
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FunctionalitiesWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}
