import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/views/attandence_detail_screen.dart';
import 'package:crm_flutter/app/modules/hrm/employee/controllers/employee_controller.dart';
import 'package:crm_flutter/app/modules/hrm/employee/widget/employee_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/attendence_controller.dart';
import '../widget/attendance_card.dart';

//
// class AttendanceScreen extends StatelessWidget {
//   AttendanceScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<AttendanceControllerHRM>(() => AttendanceControllerHRM());
//     final AttendanceControllerHRM controller = Get.find();
//     Get.lazyPut(() => EmployeeController());
//     final EmployeeController employeeController = Get.find();
//
//     void _deleteAttendance(String id, String name) {
//       Get.dialog(
//         CrmDeleteDialog(
//           entityType: name,
//           onConfirm: () async {
//             final success = await controller.deleteAttendance(id);
//             if (success) {
//               Get.back();
//               CrmSnackBar.showAwesomeSnackbar(
//                 title: "Success",
//                 message: "Attendance deleted successfully",
//                 contentType: ContentType.success,
//               );
//             }
//           },
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Attendance")),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     // Navigate to add attendance screen
//       //     controller.resetForm();
//       //     Get.to(() => AddAttendanceScreen());
//       //   },
//       //   child: const Icon(Icons.add, color: Colors.white),
//       // ),
//       body: FutureBuilder(
//         future: controller.loadInitial(),
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
//               if (!controller.isLoading.value && controller.items.isEmpty) {
//                 return const Center(
//                   child: Text("No Attendance records found."),
//                 );
//               }
//               return NotificationListener<ScrollEndNotification>(
//                 onNotification: (scrollEnd) {
//                   final metrics = scrollEnd.metrics;
//                   if (metrics.atEdge && metrics.pixels != 0) {
//                     controller.loadMore();
//                   }
//                   return false;
//                 },
//                 child: RefreshIndicator(
//                   onRefresh: controller.refreshList,
//                   child: ListView.builder(
//                     itemCount: controller.items.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index < controller.items.length) {
//                         final attendance = controller.items[index];
//
//                         return Stack(
//                           children: [
//                             GestureDetector(
//                               onTap:
//                                   () => Get.to(
//                                     () => AttendanceDetailScreen(
//                                       attendanceData: [attendance],
//                                     ),
//                                   ),
//                               child: AttendanceCard(attendance: attendance),
//                             ),
//                             Positioned(
//                               right: 8,
//                               bottom: 8,
//                               child: Row(
//                                 children: [
//                                   // IconButton(
//                                   //   icon: const Icon(
//                                   //     Icons.edit,
//                                   //     color: Colors.blue,
//                                   //   ),
//                                   //   onPressed: () {
//                                   //     Get.to(
//                                   //           () => AddAttendanceScreen(
//                                   //         attendance: attendance,
//                                   //         isFromEdit: true,
//                                   //       ),
//                                   //     );
//                                   //   },
//                                   // ),
//                                   // IconButton(
//                                   //   icon: const Icon(
//                                   //     Icons.delete,
//                                   //     color: Colors.red,
//                                   //   ),
//                                   //   onPressed: () {
//                                   //     _deleteAttendance(
//                                   //       attendance.id ?? '',
//                                   //       attendance.holidayName ?? 'Attendance',
//                                   //     );
//                                   //   },
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       } else if (controller.isPaging.value) {
//                         return const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     },
//                   ),
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
class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({Key? key}) : super(key: key);

  Future<void> _loadInitial(
    AttendanceControllerHRM controller,
    EmployeeController employeeController,
  ) async {
    controller.loadInitial();
    employeeController.loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AttendanceControllerHRM>(() => AttendanceControllerHRM());
    final AttendanceControllerHRM attendanceController = Get.find();
    Get.lazyPut(() => EmployeeController());
    final EmployeeController employeeController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: FutureBuilder(
        future: _loadInitial(attendanceController, employeeController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CrmLoadingCircle());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (!employeeController.isLoading.value &&
                  employeeController.items.isEmpty) {
                return const Center(child: Text("No Employees found."));
              }
              return RefreshIndicator(
                onRefresh: employeeController.refreshList,
                child: ViewScreen(
                  itemCount: employeeController.items.length,
                  itemBuilder: (context, index) {
                    final employee = employeeController.items[index];

                    return GestureDetector(
                      onTap: () async {
                        /// fetch attendance for this employee
                        // final DateTime now = DateTime.now();
                        // final DateTime startOfMonth = DateTime(
                        //   now.year,
                        //   now.month,
                        //   1,
                        // );
                        // final DateTime endOfMonth = DateTime(
                        //   now.year,
                        //   now.month + 1,
                        //   0,
                        // ); // last day of month
                        //
                        // final data = await attendanceController
                        //     .getAttendanceForEmployee(
                        //       employee.id ?? "",
                        //       startOfMonth,
                        //       endOfMonth,
                        //     );

                        final DateTime now = DateTime.now();
                        final DateTime startOfYear = DateTime(now.year, 1, 1);
                        final DateTime endOfYear = DateTime(now.year, 12, 31);

                        final data = await attendanceController
                            .getAttendanceForEmployee(
                              employee.id ?? "",
                              startOfYear,
                              endOfYear,
                            );

                        Get.to(
                          () => AttendanceDetailScreen(attendanceData: data),
                        );
                      },
                      child: EmployeeCard(
                        employeeId: employee.id,
                        firstName: employee.firstName,
                        lastName: employee.lastName,
                        email: employee.email,

                        joiningDate: DateFormat(
                          'yyyy-MM-dd',
                        ).format(employee.joiningDate!),
                        profilePic: employee.profilePic,
                      ),
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
