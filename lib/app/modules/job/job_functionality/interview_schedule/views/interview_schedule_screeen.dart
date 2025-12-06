import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/interview_schedule/widget/interview_schedule_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/access_res.dart';
import '../../../../../care/constants/color_res.dart';
import '../../../../../care/constants/ic_res.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/interview_schedule/interview_schedule_model.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/display/crm_ic.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/interview_schedule_controller.dart';
import 'add_interview_schedule_screen.dart';


class InterviewScheduleCalendarScreen extends StatefulWidget {
  const InterviewScheduleCalendarScreen({super.key});

  @override
  State<InterviewScheduleCalendarScreen> createState() =>
      _InterviewScheduleCalendarScreenState();
}

class _InterviewScheduleCalendarScreenState
    extends State<InterviewScheduleCalendarScreen> {
  late final InterviewScheduleController controller;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InterviewScheduleController());
    pageController = PageController(initialPage: 1000);
  }

  void _jumpToMonth(int delta) {
    pageController.animateToPage(
      pageController.page!.toInt() + delta,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _deleteOfferLetter(String id) {
    Get.dialog(
      CrmDeleteDialog(
        entityType: "Offer Letter",
        onConfirm: () async {
          final success = await controller.deleteInterviewSchedule(id);
          if (success) {
            Get.back();
            CrmSnackBar.showAwesomeSnackbar(
              title: "Success",
              message: "Offer letter deleted successfully",
              contentType: ContentType.success,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AccessController>(() => AccessController());
    final AccessController accessController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("Interview Calendar")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // --- Month Navigation ---
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CrmCard(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_left),
                              onPressed: () => _jumpToMonth(-1),
                            ),
                            Text(
                              DateFormat.yMMMM()
                                  .format(controller.focusedMonth.value),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: () => _jumpToMonth(1),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Mon"),
                          Text("Tue"),
                          Text("Wed"),
                          Text("Thu"),
                          Text("Fri"),
                          Text("Sat"),
                          Text("Sun"),
                        ],
                      ),
                      // PageView for Calendar Grid
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (index) {
                            final delta = index - 1000;
                            controller.focusedMonth.value = DateTime(
                              controller.focusedMonth.value.year,
                              controller.focusedMonth.value.month + delta,
                            );
                            pageController.jumpToPage(1000);
                          },
                          itemBuilder: (context, index) {
                            return Obx(
                                  () => GridView.count(
                                crossAxisCount: 7,
                                physics: const BouncingScrollPhysics(),
                                children: controller.buildCalendarDays(
                                  onEmptyDayTap: (selectedDate) {
                                    // Navigate to Add Schedule form
                                    controller.resetForm();
                                    Get.to(() => AddInterviewScheduleScreen(
                                      selectedDate: selectedDate,
                                    ));
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(),

            // --- Events List ---
            Obx(() {
              List<InterviewScheduleData> schedules;

              if (controller.selectedDay.value != null) {
                schedules =
                    controller.getSchedulesForDay(controller.selectedDay.value!);
              } else {
                schedules = controller.getSchedulesForFocusedMonth();
              }

              if (schedules.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      controller.selectedDay.value != null
                          ? "No schedules for this day"
                          : "No schedules this month",
                    ),
                  ),
                );
              }

              return Expanded(
                child: ViewScreen(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];

                    return Stack(
                      children: [
                        InterviewScheduleCard(schedule: schedule),
                        Positioned(
                          right: 26,
                          bottom: 8,
                          child: Row(
                            children: [

                              if (accessController.can(
                                AccessModule.jobOfferLetter,
                                AccessAction.delete,
                              ))
                                CrmIc(
                                  iconPath: ICRes.delete,
                                  color: ColorRes.error,
                                  onTap: () {
                                    _deleteOfferLetter(
                                      schedule.id ?? '',
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Assign color by interview type
  Color _getColorByType(String? type) {
    switch (type?.toLowerCase()) {
      case "online":
        return Colors.blue;
      case "offline":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
