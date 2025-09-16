// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:crm_flutter/app/care/constants/color_res.dart';
// import 'package:crm_flutter/app/care/constants/ic_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/care/utils/format.dart';
// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
// import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
// import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/widget/chat_user_card.dart';
// import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
// import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
// import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
// import '../../../../../widgets/common/messages/crm_snack_bar.dart';
//
// class ChatUserScreen extends StatelessWidget {
//   RxString userId = ''.obs;
//   ChatUserScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<UsersController>(() => UsersController());
//     final UsersController controller = Get.find();
//     final AccessController accessController = Get.find<AccessController>();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final user = await SecureStorage.getUserData();
//       if (user != null) {
//         userId.value = user.id ?? '';
//       }
//     });
//
//     // void _deleteEmployee(String id, String name) {
//     //   Get.dialog(
//     //     CrmDeleteDialog(
//     //       entityType: name,
//     //       onConfirm: () async {
//     //         final success = await controller.deleteEmployee(id);
//     //         if (success) {
//     //           Get.back();
//     //           CrmSnackBar.showAwesomeSnackbar(
//     //             title: "Success",
//     //             message: "Employee deleted successfully",
//     //             contentType: ContentType.success,
//     //           );
//     //         }
//     //       },
//     //     ),
//     //   );
//     // }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Employees")),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     // Navigate to add employee screen
//       //     Get.to(() => AddChatUserScreen());
//       //   },
//       //   child: const Icon(Icons.add, color: Colors.white),
//       // ),
//       body: FutureBuilder(
//         future: controller.fetchUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CrmLoadingCircle());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: SizedBox(
//                 width: 250,
//                 child: Text(
//                   'Server Error:\n${snapshot.error}',
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             return Obx(() {
//               if (!controller.isLoading.value && controller.users.isEmpty) {
//                 return const Center(child: Text("No Employees found."));
//               }
//
//               if (userId == null || userId.value == '') {
//                 return const Center(child: CrmLoadingCircle());
//               }
//
//               final users =
//                   controller.users.where((u) => u.clientId == userId).toList();
//
//               return RefreshIndicator(
//                 onRefresh: controller.refreshList,
//                 child: ViewScreen(
//                   itemCount: users.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index < users.length) {
//                       final user = users[index];
//                       return Stack(
//                         children: [
//                           ChatUserCard(user: user),
//                           // Uncomment if you want Edit
//
//                           // Positioned(
//                           //   right: 26,
//                           //   bottom: 8,
//                           //   child: Row(
//                           //     children: [
//                           //       if (accessController.can(
//                           //         AccessModule.employee,
//                           //         AccessAction.update,
//                           //       ))
//                           //         CrmIc(
//                           //           iconPath: ICRes.edit,
//                           //           color: ColorRes.success,
//                           //
//                           //           onTap: () {
//                           //             Get.to(
//                           //                   () => AddChatUserScreen(
//                           //                 employeeData: employee,
//                           //                 isFromEdit: true,
//                           //               ),
//                           //             );
//                           //           },
//                           //         ),
//                           //       SizedBox(width: 16,),
//                           //       if (accessController.can(
//                           //         AccessModule.employee,
//                           //         AccessAction.delete,
//                           //       ))
//                           //         CrmIc(
//                           //           iconPath: ICRes.delete,
//                           //           color: ColorRes.error,
//                           //           onTap: () {
//                           //             _deleteEmployee(
//                           //               employee.id ?? '',
//                           //               "${employee.firstName} ${employee.lastName}" ??
//                           //                   'Designation',
//                           //             );
//                           //           },
//                           //         ),
//                           //     ],
//                           //   ),
//                           // ),
//                         ],
//                       );
//                     }
//                     // else if (controller.isPaging.value) {
//                     //   return const Padding(
//                     //     padding: EdgeInsets.all(16.0),
//                     //     child: Center(child: CircularProgressIndicator()),
//                     //   );
//                     // }
//                     else {
//                       return const SizedBox.shrink();
//                     }
//                   },
//                 ),
//               );
//             });
//           } else {
//             return const Center(child: Text("Something went wrong."));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
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

import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class ChatUserScreen extends StatelessWidget {
  final RxString userId = ''.obs;

  ChatUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<UsersController>(() => UsersController());
    final UsersController controller = Get.find();
    final AccessController accessController = Get.find<AccessController>();

    // Load logged-in user ID after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await SecureStorage.getUserData();
      if (user != null) {
        userId.value = user.id ?? '';
      }
    });

    // void _deleteUser(String id, String name) {
    //   Get.dialog(
    //     CrmDeleteDialog(
    //       entityType: name,
    //       onConfirm: () async {
    //         final success = await controller.deleteEmployee(id);
    //         if (success) {
    //           Get.back();
    //           CrmSnackBar.showAwesomeSnackbar(
    //             title: "Success",
    //             message: "Employee deleted successfully",
    //             contentType: ContentType.success,
    //           );
    //         }
    //       },
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      // Floating Add Button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.to(() => AddChatUserScreen()),
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
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

              // Filter users by clientId == logged-in userId
              final users =
                  controller.users
                      .where((u) => u.clientId == userId.value)
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
                          user: user,
                          onTap: (u) {
                            Get.to(
                              () => ChatScreen(
                                userId: userId.value,
                                receiverId: u.id,
                              ),
                            );
                          },
                        ),

                        // Edit/Delete Actions
                        // Positioned(
                        //   right: 26,
                        //   bottom: 8,
                        //   child: Row(
                        //     children: [
                        //       if (accessController.can(
                        //         AccessModule.employee,
                        //         AccessAction.update,
                        //       ))
                        //         CrmIc(
                        //           iconPath: ICRes.edit,
                        //           color: ColorRes.success,
                        //           onTap: () {
                        //             // Get.to(() => AddChatUserScreen(
                        //             //       employeeData: user,
                        //             //       isFromEdit: true,
                        //             //     ));
                        //           },
                        //         ),
                        //       if (accessController.can(
                        //         AccessModule.employee,
                        //         AccessAction.delete,
                        //       ))
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 16),
                        //           child: CrmIc(
                        //             iconPath: ICRes.delete,
                        //             color: ColorRes.error,
                        //             onTap: () {
                        //               _deleteUser(
                        //                 user.id ?? '',
                        //                 user.username ?? 'Employee',
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // ),
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
