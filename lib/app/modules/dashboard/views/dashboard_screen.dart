import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/key_res.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/views/chat_user_screen.dart';
import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/hrm/hrm_functions/view/hrm_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functions/view/purchase_screen.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/database/helper/sqlite_db_helper.dart';
import '../../../data/database/storage/secure_storage_service.dart';
import '../../communication/communication_functionality/chat/controllers/chat_controller.dart';
import '../../crm/crm_functions/view/crm_screen.dart';
import '../../purchase/purchase_functions/view/purchase_screen.dart';
import '../../sales/sales_functions/view/sales_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ChatController chatController = Get.find();
  RxInt unreadCount = 0.obs;
  @override
  void initState() {
    // Get.lazyPut<AccessController>(() => AccessController());
    super.initState();
    _initAccessController();
  }

  Future<void> _initAccessController() async {
    // Initialize AccessController if not already
    AccessController accessController;
    if (!Get.isRegistered<AccessController>()) {
      accessController = Get.put(AccessController());
    } else {
      accessController = Get.find<AccessController>();
    }

    // Fetch role data
    final DBHelper dbHelper = DBHelper();
    final user = await SecureStorage.getUserData();

    if (user != null) {
      chatController.connect(
        'https://api.raiser.in',
        query: {'userId': user.id},
        userId: user.id!,
      );
    }
    final roleId = user?.roleId;
    if (roleId == null) return;

    final roleData = await dbHelper.getRoleById(roleId);
    if (roleData == null) return;

    // Initialize AccessController with permissions
    accessController.init(roleData.permissions ?? {});

    // // Now safely update functions
    // updateFunctions(accessController);
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    return Scaffold(
      key: KeyRes.scaffoldKey,
      extendBody: true,
      drawer: CrmDrawer(),
      appBar: CrmAppBar(),
      bottomNavigationBar: CrmNavigationBar(),
      body: Obx(() {
        if (navigationController.currentIndex.value == 0) {
          return HomeScreen();
        } else if (navigationController.currentIndex.value == 1) {
          return CrmScreen();
        } else if (navigationController.currentIndex.value == 2) {
          return SalesScreen();
        } else if (navigationController.currentIndex.value == 3) {
          return PurchaseScreen();
        } else if (navigationController.currentIndex.value == 4) {
          return HrmScreen();
        } else {
          return SizedBox();
        }
      }),
      // floatingActionButton: Stack(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.all(10),
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           Get.to(() => ChatUserScreen());
      //         },
      //         child: Icon(Icons.chat, color: ColorRes.white),
      //       ),
      //     ),
      //     Positioned(
      //       child: Obx(() {
      //         chatController.unreadCount.forEach((_, value) {
      //           unreadCount.value += value;
      //         });
      //         if (unreadCount == 0) {
      //           return SizedBox.shrink();
      //         }
      //         return Container(
      //           padding: EdgeInsets.all(6),
      //           decoration: BoxDecoration(
      //             color: Colors.red,
      //             shape: BoxShape.circle,
      //           ),
      //           constraints: BoxConstraints(minWidth: 24, minHeight: 24),
      //           child: Center(
      //             child: Text(
      //               '$unreadCount',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         );
      //       }),
      //       right: 0,
      //       top: 0,
      //     ),
      //   ],
      // ),
      floatingActionButton: Obx(() {
        // calculate total unread count directly
        final int totalUnread = chatController.unreadCount.values.fold(
          0,
          (sum, value) => sum + value,
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            FloatingActionButton(
              onPressed: () {
                Get.to(() => ChatUserScreen());
              },
              backgroundColor: ColorRes.primary, // customize if needed
              child: const Icon(Icons.chat, color: Colors.white),
            ),

            // Badge
            if (totalUnread > 0)
              Positioned(
                right: -10,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 22,
                    minHeight: 22,
                  ),
                  child: Center(
                    child: Text(
                      totalUnread > 99
                          ? "99+"
                          : "$totalUnread", // cap big numbers
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
