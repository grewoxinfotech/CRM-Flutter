import 'package:crm_flutter/app/widgets/drawer/views/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(child: Center(child: CrmDrawer())),
    );
  }
}

/*
crm textFormField ,
crm leadsAndDeals ,
crm tabBar















*/