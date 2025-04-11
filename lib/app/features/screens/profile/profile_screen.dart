import 'package:crm_flutter/app/features/data/auth/auth_controller.dart';
import 'package:crm_flutter/app/features/data/profile/profile_controller.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    AuthController authController = Get.find<AuthController>();
    Get.lazyPut(() => AuthController(), fenix: true);

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CrmCard(
                padding: EdgeInsets.all(10),
                width: 600,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CrmProfile(radius: 50),
                    Divider(color: Colors.grey[300]),

                    Obx(() => Text(profileController.username.value)),
                    CrmButton(
                      title: "Logout",
                      onTap: () {
                        Get.defaultDialog(
                          title: "Logout",
                          middleText: "Are you sure you want to logout?",
                          textCancel: "Cancel",
                          textConfirm: "Logout",
                          onConfirm: () {
                            Get.back(); // close dialog
                            authController.logout();
                          },
                        );
                      },
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
