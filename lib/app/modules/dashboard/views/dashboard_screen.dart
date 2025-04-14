import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/widgets/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/navigation_bar/crm_navigation_Bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: CrmCard(
          width: Get.width * 0.8,
          margin: PaddingRes.all2,
          padding: PaddingRes.all2,
          child: ListView(
            children: [
              CrmCard(
                padding: PaddingRes.all3,
                color: Get.theme.colorScheme.primary.withAlpha(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CrmIc(
                      iconPath: ICRes.project,
                      color: Get.theme.colorScheme.primary,
                    ),
                    Space(),
                    Text(
                      "project",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Obx(
                () =>
                    navigationBarController.selectedIndex.value == 0
                        ? const HomeScreen()
                        : SizedBox(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [CrmAppBar(), CrmNavigationBar()],
            ),
          ],
        ),
      ),
    );
  }
}
