import 'package:crm_flutter/app/features/presentation/screens/home/home_view_model.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final CrmBottemNavigationBarController navigationBarController = Get.put(
    CrmBottemNavigationBarController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Obx(
                    () =>
                navigationBarController.selectedIndex.value == 0
                    ? const HomeViewModel()
                    : SizedBox(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [CrmAppBar(), CrmBottomNavigationBar()],
            ),
          ],
        ),
      ),
    );
  }
}
