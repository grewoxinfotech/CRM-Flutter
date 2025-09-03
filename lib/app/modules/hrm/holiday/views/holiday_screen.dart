import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/access_res.dart';
import '../../../../care/constants/color_res.dart';
import '../../../../care/constants/ic_res.dart';
import '../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../widgets/common/display/crm_ic.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../access/controller/access_controller.dart';
import '../controllers/holiday_controller.dart';
import '../widget/holiday_card.dart';
import 'add_holiday_screen.dart';

class HolidayScreen extends StatelessWidget {
  HolidayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Get.lazyPut<HolidayController>(() => HolidayController());
    final HolidayController controller = Get.find();

    void _deleteHoliday(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteHoliday(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Holiday deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Holidays")),
      floatingActionButton:
          accessController.can(AccessModule.holiday, AccessAction.create)
              ? FloatingActionButton(
                onPressed: () {
                  controller.resetForm();
                  Get.to(() => AddHolidayScreen());
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
                return const Center(child: Text("No Holidays found."));
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
                        final holiday = controller.items[index];
                        return Stack(
                          children: [
                            HolidayCard(holiday: holiday),
                            Positioned(
                              right: 26,
                              bottom: 8,
                              child: Row(
                                children: [
                                  if (accessController.can(
                                    AccessModule.holiday,
                                    AccessAction.update,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.edit,
                                      color: ColorRes.success,
                                      onTap: () {
                                        Get.to(
                                          () => AddHolidayScreen(
                                            holiday: holiday,
                                            isFromEdit: true,
                                          ),
                                        );
                                      },
                                    ),
                                  SizedBox(width: 12,),
                                  if (accessController.can(
                                    AccessModule.holiday,
                                    AccessAction.delete,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.delete,
                                      color: ColorRes.error,
                                      onTap: () {
                                        _deleteHoliday(
                                          holiday.id ?? '',
                                          holiday.holidayName ?? 'Holiday',
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
