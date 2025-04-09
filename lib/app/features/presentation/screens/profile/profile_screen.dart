import 'package:crm_flutter/app/features/data/auth/auth_controller.dart';
import 'package:crm_flutter/app/features/data/profile/profile_controller.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ProfileController profileController = Get.put(ProfileController());
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CrmContainer(
                padding: EdgeInsets.all(10),
                width: 600,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CrmProfile(
                      radius: 50,
                    ),
                    Divider(
                      color: Colors.grey[300],
                    ),

                    Obx(()=> Text(profileController.username.value)),
                    
                    CrmButton(title: "Logout", onPressed: ()=> authController.logout())

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
