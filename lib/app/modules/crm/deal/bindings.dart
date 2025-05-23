import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/data/network/role/service/roles_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/modules/crm/notes/controllers/note_controller.dart';
import 'package:crm_flutter/app/modules/crm/file/controllers/file_controller.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/crm/deal/service/deal_service.dart';
import 'package:crm_flutter/app/data/network/activity/service/activity_service.dart';
import 'package:crm_flutter/app/modules/crm/activity/controller/activity_controller.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/service/followup_task_service.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/controller/followup_task_controller.dart';

class DealBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize services first
    Get.lazyPut<RolesService>(() => RolesService(), fenix: true);
    Get.lazyPut<NoteService>(() => NoteService(), fenix: true);
    Get.lazyPut<DealService>(() => DealService());

    // Then initialize controllers that might depend on services
    Get.lazyPut<DealController>(() => DealController(), fenix: true);
    Get.lazyPut<TabBarController>(() => TabBarController(), fenix: true);
    Get.lazyPut<NoteController>(() => NoteController(), fenix: true);
    Get.lazyPut<FileController>(() => FileController(), fenix: true);
    Get.lazyPut<ActivityService>(() => ActivityService());
    Get.lazyPut<ActivityController>(() => ActivityController());
    Get.lazyPut<FollowUpTaskService>(() => FollowUpTaskService());
    Get.lazyPut<FollowUpTaskController>(() => FollowUpTaskController());
  }
}
