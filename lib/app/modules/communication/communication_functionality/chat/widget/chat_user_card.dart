import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/super_admin/auth/model/user_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../role/controllers/role_controller.dart';

class ChatUserCard extends StatelessWidget {
  final User user;
  final Function(User)? onTap;

  const ChatUserCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<RoleController>(() => RoleController());
    final RoleController roleController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await roleController.getRoleName(user.roleId);
    });
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(user);
        } else {
          // Default action: navigate to chat screen with this user
          // Get.to(() => ChatDetailScreen(userId: user.id));
        }
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              child: Text(
                (user.firstName != null && user.firstName!.isNotEmpty)
                    ? user.firstName![0].toUpperCase()
                    : '?',

                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.username ?? 'No Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 4),
                      Obx(() {
                        final role = roleController.roles.firstWhereOrNull(
                          (role) => role.id == user.roleId,
                        );
                        if (role == null) {
                          return SizedBox.shrink();
                        }
                        return Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorRes.primary,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.small,
                            ),
                          ),
                          child: Text(
                            '${role.roleName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (user.email != null && user.email!.isNotEmpty)
                    Text(
                      user.email!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                  // if (user.createdBy != null && user.createdBy!.isNotEmpty)
                  //   Text(
                  //     'Created by: ${user.createdBy}',
                  //     style: const TextStyle(fontSize: 12, color: Colors.grey),
                  //   ),
                ],
              ),
            ),
            // const Icon(
            //   CupertinoIcons.chat_bubble_2_fill,
            //   color: Colors.blueAccent,
            // ),
          ],
        ),
      ),
    );
  }
}
