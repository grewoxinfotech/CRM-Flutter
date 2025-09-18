import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../role/controllers/role_controller.dart';
import '../controllers/chat_controller.dart';

class ChatUserCard extends StatelessWidget {
  final User user;
  final Function(User)? onTap;
  final ChatController chatController;

  const ChatUserCard({
    super.key,
    required this.user,
    this.onTap,
    required this.chatController,
  });

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.username ?? 'No Name',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 4),
                            Obx(() {
                              final role = roleController.roles
                                  .firstWhereOrNull(
                                    (role) => role.id == user.roleId,
                                  );
                              if (role == null) {
                                return SizedBox.shrink();
                              }

                              return Text(
                                '${role.roleName}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: ColorRes.grey,
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 4),

                        Obx(() {
                          final isTyping =
                              chatController.typingStatus[user.id] ?? false;

                          if (isTyping) {
                            return Text(
                              'typing...',
                              style: TextStyle(
                                color: ColorRes.grey,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          }

                          final status = chatController.userStatus[user.id];
                          if (status == null) {
                            return Text(
                              "Start Chat",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          }

                          final isOnline = status['isOnline'] ?? false;
                          final lastSeen = status['lastSeen'] ?? '';

                          return Text(
                            isOnline
                                ? "Online"
                                : "Last seen: ${formatTime(DateTime.tryParse(lastSeen)!)}",
                            style: TextStyle(
                              color: isOnline ? Colors.green : Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              final unreadCount = chatController.unreadCount[user.id] ?? 0;
              if (unreadCount == 0) return const SizedBox.shrink();
              return Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(AppSpacing.extraLarge),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
