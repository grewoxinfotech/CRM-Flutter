import 'package:crm_flutter/app/features/presentation/screens/home/features/home_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CrmBottemNavigationBarController navigationController = Get.put(
      CrmBottemNavigationBarController(),
    );
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                Expanded(
                  child: Obx(
                    () =>
                        navigationController.selectedIndex.value == 0
                            ? const HomeModelView()
                            : SizedBox(),
                  ),
                ),
                const SizedBox(height: 60),

              ],
            ),
            Column(
              children: [
                CrmAppBar(),
                Expanded(child: SizedBox()),
                CrmBottomNavigationBar(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
