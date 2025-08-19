import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/leave_controller.dart';
import '../widget/leave_card.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<LeaveController>(() => LeaveController());
    final LeaveController controller = Get.find();

    void _deleteLeave(String id, String type) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: type,
          onConfirm: () async {
            final success = await controller.deleteLeave(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Leave deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Leaves")),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigate to add leave screen
      //     controller.resetForm();
      //     Get.to(() => AddLeaveScreen());
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
                return const Center(child: Text("No Leaves found."));
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
                  child: ListView.builder(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final leave = controller.items[index];
                        return Stack(
                          children: [
                            LeaveCard(leave: leave),
                            Positioned(
                              right: 8,
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
                                  //           () => AddLeaveScreen(
                                  //         leave: leave,
                                  //         isFromEdit: true,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _deleteLeave(
                                        leave.id ?? '',
                                        leave.leaveType ?? 'Leave',
                                      );
                                    },
                                  ),
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
