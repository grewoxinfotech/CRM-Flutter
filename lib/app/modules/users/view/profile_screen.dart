import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/inquiry/inquiry_model.dart';
import 'package:crm_flutter/app/modules/subscription/widget/subscription_card.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../care/constants/color_res.dart';
import '../../../care/constants/font_res.dart';
import '../../../data/network/subscription/subscription_model.dart';
import '../../../widgets/button/crm_button.dart';
import '../../../widgets/common/messages/crm_snack_bar.dart';
import '../../subscription/controllers/subscription_controller.dart';
import '../../subscription/views/plans_screen.dart';
import '../../super_admin/auth/controllers/auth_controller.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubscriptionController subscriptionController = Get.put(
      SubscriptionController(),
    );
    // final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),

        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen());
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),

      body: FutureBuilder(
        future: SecureStorage.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user found"));
          }

          final user = snapshot.data!;
          final fullName = "${user.firstName ?? ''} ${user.lastName ?? ''}";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      user.profilePic != null
                          ? NetworkImage(user.profilePic!)
                          : const AssetImage("assets/icons/app_logo.png")
                              as ImageProvider,
                ),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontFamily: FontRes.nuNunitoSans,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),

                Obx(() {
                  if (subscriptionController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final subscription =
                      subscriptionController.currentSubscription.value;

                  if (subscription == null || subscription.id == null) {
                    return const Center(child: Text("No active subscription"));
                  }

                  return Column(
                    children: [
                      SubscriptionCard(
                        planName: subscription.status ?? "N/A",
                        startDate:
                            DateTime.tryParse(subscription.startDate ?? '') ??
                            DateTime.now(),
                        endDate:
                            DateTime.tryParse(subscription.endDate ?? '') ??
                            DateTime.now(),
                      ),

                      SizedBox(height: 20),
                      CrmButton(
                        title: "Renew Plan",
                        onTap: () {
                          Get.to(() => PlansScreen());
                        },
                        width: double.infinity,
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Column(
                    children: [
                      _buildTile(
                        Icons.person_outline,
                        'Username',
                        user.username ?? '-',
                      ),
                      _buildTile(
                        Icons.email_outlined,
                        'Email',
                        user.email ?? '-',
                      ),
                      _buildTile(
                        Icons.phone_outlined,
                        'Phone',
                        user.phone ?? '-',
                      ),
                      _buildTile(
                        Icons.home_outlined,
                        'Address',
                        user.address ?? '-',
                      ),
                      _buildTile(
                        Icons.location_city_outlined,
                        'City',
                        user.city ?? '-',
                      ),
                      _buildTile(
                        Icons.map_outlined,
                        'State',
                        user.state ?? '-',
                      ),
                      _buildTile(
                        Icons.flag_circle_outlined,
                        'Country',
                        user.country ?? '-',
                      ),
                      _buildTile(
                        Icons.numbers_outlined,
                        'ZIP Code',
                        user.zipcode ?? '-',
                      ),
                      _buildTile(
                        Icons.verified_user,
                        'Designation',
                        user.designation ?? '-',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: CrmButton(
                    onTap: () => Get.put(AuthController()).logout(),
                    title: 'Logout',
                  ),
                ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   width: double.infinity,
                //   child: CrmButton(
                //     onTap: () {},
                //     title: 'Delete Account',
                //     backgroundColor: ColorRes.error,
                //   ),
                // ),
                // const SizedBox(height: 26),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: FontRes.nuNunitoSans,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontFamily: FontRes.nuNunitoSans,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
