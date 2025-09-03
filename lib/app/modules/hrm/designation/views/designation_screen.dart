import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/color_res.dart';
import '../../../../care/constants/ic_res.dart';
import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/display/crm_ic.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../access/controller/access_controller.dart';
import '../controllers/designation_controller.dart';
import '../widget/designation_card.dart';
import 'add_designation_screen.dart';

class DesignationScreen extends StatelessWidget {
  DesignationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Get.lazyPut<DesignationController>(() => DesignationController());
    final DesignationController controller = Get.find();

    void _deleteDesignation(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteDesignation(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Designation deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Designations")),
      floatingActionButton:
          accessController.can(AccessModule.designation, AccessAction.create)
              ? FloatingActionButton(
                onPressed: () {
                  // Navigate to add designation screen
                  controller.resetForm();
                  Get.to(() => AddDesignationScreen());
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
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
                return const Center(child: Text("No Designations found."));
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
                        final designation = controller.items[index];
                        return Stack(
                          children: [
                            DesignationCard(designation: designation),
                            Positioned(
                              right: 26,
                              bottom: 8,
                              child: Row(
                                children: [
                                  // Uncomment if you want Edit
                                  if (accessController.can(
                                    AccessModule.designation,
                                    AccessAction.update,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.edit,
                                      color: ColorRes.success,
                                      onTap: () {
                                        Get.to(
                                          () => AddDesignationScreen(
                                            designation: designation,
                                            isFromEdit: true,
                                          ),
                                        );
                                      },
                                    ),
                                  SizedBox(width: 12,),
                                  if (accessController.can(
                                    AccessModule.designation,
                                    AccessAction.delete,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.delete,
                                      color: ColorRes.error,
                                      onTap: () {
                                        _deleteDesignation(
                                          designation.id ?? '',
                                          designation.designationName ??
                                              'Designation',
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
