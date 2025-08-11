import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:get/get.dart';

import '../../contact/controller/contact_controller.dart';
import '../controllers/lead_controller.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize services first
    Get.lazyPut<RolesService>(() => RolesService(), fenix: true);
    Get.lazyPut<LabelService>(() => LabelService(), fenix: true);
    
    // Initialize controllers that don't depend on LabelController
    Get.lazyPut<TabBarController>(() => TabBarController(), fenix: true);
    Get.lazyPut<UsersController>(() => UsersController(), fenix: true);
    Get.lazyPut<RoleController>(() => RoleController(), fenix: true);
    Get.lazyPut<ContactController>(() => ContactController(), fenix: true);
    
    // Initialize LabelController before LeadController
    Get.lazyPut<LabelController>(() => LabelController(), fenix: true);
    
    // Finally initialize LeadController which depends on LabelController
    Get.lazyPut<LeadController>(() => LeadController(), fenix: true);
  }
}
