import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/access_res.dart';
import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/employee_controller.dart';
import '../widget/employee_card.dart';
import 'add_employee_screen.dart';

class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
    final AccessController accessController = Get.find<AccessController>();
    final EmployeeController controller = Get.find();

    void _deleteEmployee(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteEmployee(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Employee deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add employee screen
          Get.to(() => AddEmployeeScreen());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
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
                return const Center(child: Text("No Employees found."));
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
                        final employee = controller.items[index];
                        return Stack(
                          children: [
                            EmployeeCard(
                              id: employee.id,
                              firstName: employee.firstName,
                              lastName: employee.lastName,
                              email: employee.email,
                              phone: employee.phone,
                              address: employee.address,
                              branch: employee.branch,
                              employeeId: employee.employeeId,
                              currency: employee.currency,
                              username: employee.username,
                              department: employee.department,
                              designation: employee.designation,
                              joiningDate: formatDateString(
                                employee.joiningDate?.toIso8601String(),
                              ),
                              phoneCode: employee.phoneCode,
                              salary: employee.salary,
                            ),
                            // Uncomment if you want Edit

                              Positioned(
                                right: 26,
                                bottom: 8,
                                child: Row(
                                  children: [
                                    if (accessController.can(
                                      AccessModule.employee,
                                      AccessAction.update,
                                    ))
                                    CrmIc(
                                      iconPath: ICRes.edit,
                      color: ColorRes.success,

                                      onTap: () {
                                        Get.to(
                                              () => AddEmployeeScreen(
                                            employeeData: employee,
                                            isFromEdit: true,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 16,),
                                    if (accessController.can(
                                      AccessModule.employee,
                                      AccessAction.delete,
                                    ))
                                      CrmIc(
                                        iconPath: ICRes.delete,
                                        color: ColorRes.error,
                                      onTap: () {
                                        _deleteEmployee(
                                          employee.id ?? '',
                                          "${employee.firstName} ${employee.lastName}" ??
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
