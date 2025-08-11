
import 'package:crm_flutter/app/modules/crm/crm_functionality/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/notes/controllers/note_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:get/get.dart';

import '../file/controllers/file_controller.dart';

class DealBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize services first
    Get.lazyPut<RolesService>(() => RolesService(), fenix: true);
    Get.lazyPut<NoteService>(() => NoteService(), fenix: true);
    Get.lazyPut<AllUsersService>(() => AllUsersService(), fenix: true);

    // Then initialize controllers that might depend on services
    Get.lazyPut<DealController>(() => DealController(), fenix: true);
    Get.lazyPut<TabBarController>(() => TabBarController(), fenix: true);
    Get.lazyPut<NoteController>(() => NoteController(), fenix: true);
    Get.lazyPut<FileController>(() => FileController(), fenix: true);
    Get.lazyPut<PipelineController>(() => PipelineController(), fenix: true);
  }
}
