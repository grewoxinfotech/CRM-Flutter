import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../access/controller/access_controller.dart';
import '../controllers/job_list_controller.dart';
import '../widget/job_list_card.dart';

class JobListScreen extends StatelessWidget {
  JobListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Get.lazyPut<JobListController>(() => JobListController());
    final JobListController controller = Get.find();

    void _deleteJob(String id, String title) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: title,
          onConfirm: () async {
            final success = await controller.deleteJob(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Job deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Jobs")),
      // floatingActionButton:
      // accessController.can(AccessModule.jobs, AccessAction.create)
      //     ? FloatingActionButton(
      //   onPressed: () {
      //     // Navigate to add job screen
      //     Get.to(() => AddJobScreen());
      //   },
      //   child: const Icon(Icons.add, color: Colors.white),
      // )
      //     : null,
      body: FutureBuilder(
        future: controller.fetchJobs(),
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
              if (!controller.isLoading.value && controller.jobs.isEmpty) {
                return const Center(child: Text("No Jobs found."));
              }
              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.fetchJobs(
                      page: (controller.pagination.value.current ?? 1) + 1,
                    );
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: () async => controller.fetchJobs(),
                  child: ViewScreen(
                    itemCount: controller.jobs.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.jobs.length) {
                        final job = controller.jobs[index];
                        return Stack(
                          children: [
                            JobListCard(job: job),
                            // Positioned(
                            //   right: 26,
                            //   bottom: 8,
                            //   child: Row(
                            //     children: [
                            //       if (accessController.can(
                            //         AccessModule.jobs,
                            //         AccessAction.update,
                            //       ))
                            //         CrmIc(
                            //           iconPath: ICRes.edit,
                            //           color: ColorRes.success,
                            //           onTap: () {
                            //             Get.to(
                            //                   () => AddJobScreen(
                            //                 job: job,
                            //                 isFromEdit: true,
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       const SizedBox(width: 12),
                            //       if (accessController.can(
                            //         AccessModule.jobs,
                            //         AccessAction.delete,
                            //       ))
                            //         CrmIc(
                            //           iconPath: ICRes.delete,
                            //           color: ColorRes.error,
                            //           onTap: () {
                            //             _deleteJob(
                            //               job.id ?? '',
                            //               job.title ?? 'Job',
                            //             );
                            //           },
                            //         ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        );
                      } else if (controller.isLoading.value) {
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
