import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/calendar/calendar_model.dart';
import '../controllers/calendar_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final CalendarController controller;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CalendarController());
    pageController = PageController(
      initialPage: 1000,
    ); // large number for infinite-like scrolling
  }

  void _jumpToMonth(int delta) {
    pageController.animateToPage(
      pageController.page!.toInt() + delta,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Month Navigation
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
                              onPressed: () {
                                _jumpToMonth(-1);
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                // int selectedYear =
                                //     controller.focusedMonth.value.year;
                                // int selectedMonth =
                                //     controller.focusedMonth.value.month;
                                //
                                // await showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       title: const Text("Select Month & Year"),
                                //       content: Row(
                                //         children: [
                                //           DropdownButton<int>(
                                //             value: selectedMonth,
                                //             items:
                                //                 List.generate(12, (i) => i + 1)
                                //                     .map(
                                //                       (m) => DropdownMenuItem(
                                //                         value: m,
                                //                         child: Text(
                                //                           DateFormat.MMMM()
                                //                               .format(
                                //                                 DateTime(0, m),
                                //                               ),
                                //                         ),
                                //                       ),
                                //                     )
                                //                     .toList(),
                                //             onChanged:
                                //                 (v) =>
                                //                     selectedMonth =
                                //                         v ?? selectedMonth,
                                //           ),
                                //           const SizedBox(width: 16),
                                //           DropdownButton<int>(
                                //             value: selectedYear,
                                //             items:
                                //                 List.generate(
                                //                       21,
                                //                       (i) =>
                                //                           DateTime.now().year -
                                //                           10 +
                                //                           i,
                                //                     )
                                //                     .map(
                                //                       (y) => DropdownMenuItem(
                                //                         value: y,
                                //                         child: Text("$y"),
                                //                       ),
                                //                     )
                                //                     .toList(),
                                //             onChanged:
                                //                 (v) =>
                                //                     selectedYear =
                                //                         v ?? selectedYear,
                                //           ),
                                //         ],
                                //       ),
                                //       actions: [
                                //         TextButton(
                                //           onPressed:
                                //               () => Navigator.pop(context),
                                //           child: const Text("Cancel"),
                                //         ),
                                //         TextButton(
                                //           onPressed: () {
                                //             controller
                                //                 .focusedMonth
                                //                 .value = DateTime(
                                //               selectedYear,
                                //               selectedMonth,
                                //               1,
                                //             );
                                //             Navigator.pop(context);
                                //           },
                                //           child: const Text("OK"),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              child: Text(
                                DateFormat.yMMMM().format(
                                  controller.focusedMonth.value,
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: () {
                                _jumpToMonth(1);
                              },
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
                      // PageView for Month Grid
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
                            final delta = index - 1000;
                            final monthDate = DateTime(
                              controller.focusedMonth.value.year,
                              controller.focusedMonth.value.month + delta,
                            );
                            return Obx(
                              () => GridView.count(
                                crossAxisCount: 7,
                                physics: const BouncingScrollPhysics(),
                                children: controller.buildCalendarDays(),
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
            // Events List
            // Obx(() {
            //   if (controller.selectedDay.value == null) {
            //     return const Expanded(
            //       child: Center(child: Text("Select a day to see events")),
            //     );
            //   }
            //   final events = controller.getEventsForDay(
            //     controller.selectedDay.value!,
            //   );
            //   if (events.isEmpty) {
            //     return const Expanded(
            //       child: Center(child: Text("No events for this day")),
            //     );
            //   }
            //   return Expanded(
            //     child: ListView.builder(
            //       itemCount: events.length,
            //       itemBuilder:
            //           (context, index) => Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: CrmCard(
            //               padding: EdgeInsets.all(AppSpacing.small),
            //               child: ListTile(
            //                 leading: Icon(
            //                   Icons.event_rounded,
            //                   color: _getColorByLabel(events[index].label),
            //                 ),
            //                 title: Text(events[index].name ?? "Unnamed Event"),
            //                 subtitle: Text(
            //                   formatDateString(events[index].startDate!),
            //                 ),
            //                 trailing: Text(
            //                   events[index].label ?? "Other",
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w500,
            //                     color: _getColorByLabel(events[index].label),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //     ),
            //   );
            // }),

            // Events List
            Obx(() {
              List<CalendarData> events;

              if (controller.selectedDay.value != null) {
                // If a day is selected, show events for that day
                events = controller.getEventsForDay(
                  controller.selectedDay.value!,
                );
              } else {
                // If no day is selected, show all events in focused month
                events = controller.getEventsForFocusedMonth();
              }

              if (events.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      controller.selectedDay.value != null
                          ? "No events for this day"
                          : "No events this month",
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CrmCard(
                          padding: EdgeInsets.all(AppSpacing.small),
                          child: ListTile(
                            leading: Icon(
                              Icons.event_rounded,
                              color: _getColorByLabel(events[index].label),
                            ),
                            title: Text(events[index].name ?? "Unnamed Event"),
                            subtitle: Text(
                              formatDateString(events[index].startDate!),
                            ),
                            trailing: Text(
                              events[index].label ?? "Other",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _getColorByLabel(events[index].label),
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getColorByLabel(String? label) {
    switch (label?.toLowerCase()) {
      case "personal":
        return Colors.blue;
      case "work":
        return Colors.green;
      case "important":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
