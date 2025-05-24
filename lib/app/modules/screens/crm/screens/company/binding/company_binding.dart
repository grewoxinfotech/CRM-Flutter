import 'package:crm_flutter/app/modules/screens/crm/screens/company/controller/company_controller.dart';
import 'package:get/get.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(() => CompanyController());
  }
}
