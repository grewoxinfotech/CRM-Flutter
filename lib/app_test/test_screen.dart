import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_teb_bar.dart';
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
            children: [
              CrmTabBar(items: [
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
                TabItem(imagePath: IconResources.NOTIFICATION, label: "notification"),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}