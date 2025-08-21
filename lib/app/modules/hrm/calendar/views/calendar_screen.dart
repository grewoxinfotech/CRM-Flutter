import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../care/constants/size_manager.dart';
import '../controllers/calendar_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarController());

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
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.arrow_left),
                              onPressed: controller.previousMonth),
                          Text(
                            DateFormat.yMMMM().format(controller.focusedMonth.value),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: controller.nextMonth),
                        ],
                      )),
                      // Weekdays
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Mon"), Text("Tue"), Text("Wed"),
                          Text("Thu"), Text("Fri"), Text("Sat"), Text("Sun"),
                        ],
                      ),
                      // Calendar Grid
                      // Obx(() => Expanded(
                      //   child: GestureDetector(
                      //     onHorizontalDragEnd: (details) {
                      //       // Fling velocity decides direction
                      //       if (details.primaryVelocity == null) return;
                      //       if (details.primaryVelocity! > 0) {
                      //         // swipe right -> previous month
                      //         controller.previousMonth();
                      //       } else if (details.primaryVelocity! < 0) {
                      //         // swipe left -> next month
                      //         controller.nextMonth();
                      //       }
                      //     },
                      //     onPanUpdate: (details) {
                      //       // Gentle drag (without fling)
                      //       const threshold = 10.0;
                      //       if (details.delta.dx > threshold) {
                      //         controller.previousMonth();
                      //       } else if (details.delta.dx < -threshold) {
                      //         controller.nextMonth();
                      //       }
                      //     },
                      //     child: GridView.count(
                      //       crossAxisCount: 7,
                      //       children: controller.buildCalendarDays(),
                      //     ),
                      //   ),
                      // )),
                      Expanded(
                        child: Obx(
                              () => GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity == null) return;
                                  if (details.primaryVelocity! > 0) {
                                    controller.swipeDirection.value = 1; // right → previous
                                    controller.previousMonth();
                                  } else if (details.primaryVelocity! < 0) {
                                    controller.swipeDirection.value = -1; // left → next
                                    controller.nextMonth();
                                  }
                                },
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 350),
                                  transitionBuilder: (child, animation) {
                                    final offsetAnimation = Tween<Offset>(
                                      begin: Offset(controller.swipeDirection.value.toDouble(), 0),
                                      end: Offset.zero,
                                    ).animate(animation);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: GridView.count(
                                    key: ValueKey<String>(
                                      DateFormat('yyyy-MM').format(controller.focusedMonth.value),
                                    ),
                                    crossAxisCount: 7,
                                    physics: const BouncingScrollPhysics(),
                                    children: controller.buildCalendarDays(),
                                  ),
                                ),

                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            // Events List
            Obx(() {
              if (controller.selectedDay.value == null) {
                return const Expanded(
                    child: Center(child: Text("Select a day to see events")));
              }

              final events =
              controller.getEventsForDay(controller.selectedDay.value!);

              if (events.isEmpty) {
                return const Expanded(
                    child: Center(child: Text("No events for this day")));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) => CrmCard(
                    padding: EdgeInsets.all(AppSpacing.small),
                    child: ListTile(
                      leading:  Icon(Icons.event_rounded,color: _getColorByLabel(events[index].label),),
                      title: Text(events[index].name ?? "Unnamed Event"),
                      subtitle: Text(DateFormat("yyyy-MM-dd")
                          .format(DateTime.tryParse(events[index].startDate!)!)),
                      trailing: Text(
                        events[index].label ?? "Other",
                        style:  TextStyle(fontWeight: FontWeight.w500,color: _getColorByLabel(events[index].label),),
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

  /// ---- Map labels to colors ----
  Color _getColorByLabel(String? label) {
    switch (label?.toLowerCase()) {
      case "personal":
        return Colors.blue;
      case "work":
        return Colors.green;
      case "important":
        return Colors.red;
      default:
        return Colors.orange; // other
    }
  }
}
