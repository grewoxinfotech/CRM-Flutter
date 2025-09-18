import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/views/chat_screen.dart';
import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/widget/chat_user_card.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen({Key? key}) : super(key: key);

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  final ChatController chatController = Get.find();
  final RxString userId = ''.obs;

  @override
  void initState() {
    // _initChat();
    super.initState();
  }

  Future<void> _initChat() async {
    final user = await SecureStorage.getUserData();
    userId.value = user?.id ?? '';
    chatController.connect(
      'https://api.raiser.in',
      query: {'userId': userId.value},
      userId: userId.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<UsersController>(() => UsersController());
    final UsersController controller = Get.find();
    final AccessController accessController = Get.find<AccessController>();

    // Load logged-in user ID after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await SecureStorage.getUserData();
      // if (user?.employeeId != null) {
      //   userId.value = user!.clientId ?? '';
      // } else {
      //   if (user != null) {
      //     userId.value = user.id ?? '';
      //   }
      // }
      userId.value = user?.clientId ?? '';
      controller.users.removeWhere((u) => u.id == userId.value);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      body: FutureBuilder(
        future: controller.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CrmLoadingCircle());
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error:\n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (!controller.isLoading.value && controller.users.isEmpty) {
                return const Center(child: Text("No Employees found."));
              }

              if (userId.value.isEmpty) {
                return const Center(child: CrmLoadingCircle());
              }

              final users =
                  controller.users
                      .where(
                        (u) =>
                            u.clientId == userId.value || u.id == userId.value,
                      )
                      .toList();

              return RefreshIndicator(
                onRefresh: controller.refreshList,
                child: ViewScreen(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Stack(
                      children: [
                        ChatUserCard(
                          chatController: chatController,
                          user: user,
                          onTap: (u) async {
                            final userId = await SecureStorage.getUserData();
                            chatController.markMessageAsRead(
                              u.id,
                              userId?.id ?? '',
                            );
                            chatController.unreadCount[u.id] = 0;

                            print("userId: ${userId?.id}, receiverId: ${u.id}");
                            Get.to(
                              () => ChatScreen(
                                userId: userId?.id ?? '',
                                receiverId: u.id,
                                receiverName: u.username,
                                chatController: chatController,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            });
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
