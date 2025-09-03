import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/modules/hrm/role/views/roll_detail_screen.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/role_controller.dart';
import '../widget/role_card.dart';


class RoleScreen extends StatelessWidget {
  RoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<RolesController>(() => RolesController());
    final RolesController controller = Get.find();

    void _deleteRole(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteRole(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Role deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Roles")),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.resetForm();
      //     Get.to(() => AddRoleScreen());
      //   },
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      body: FutureBuilder(
        future: controller.loadInitial(),
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
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No Roles found."));
              }
              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: controller.refreshList,
                  child: ViewScreen(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final role = controller.items[index];
                        return Stack(
                          children: [
                            GestureDetector(
                            onTap: ()=>Get.to(()=> RoleDetailScreen(role: role))    ,
                            child: RoleCard(role: role)),
                            Positioned(
                              right: 26,
                              bottom: 8,
                              child: Row(
                                children: [
                                  // IconButton(
                                  //   icon: const Icon(
                                  //     Icons.edit,
                                  //     color: Colors.blue,
                                  //   ),
                                  //   onPressed: () {
                                  //     Get.to(
                                  //           () => AddRoleScreen(
                                  //         role: role,
                                  //         isFromEdit: true,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  // IconButton(
                                  //   icon: const Icon(
                                  //     Icons.delete,
                                  //     color: Colors.red,
                                  //   ),
                                  //   onPressed: () {
                                  //     _deleteRole(
                                  //       role.id ?? '',
                                  //       role.roleName ?? 'Role',
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (controller.isPaging.value) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
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
