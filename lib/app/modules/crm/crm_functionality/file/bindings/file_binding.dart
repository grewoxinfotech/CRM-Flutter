import 'package:crm_flutter/app/modules/crm/crm_functionality/file/controllers/file_controller.dart';
import 'package:get/get.dart';

class FileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileController>(() => FileController());
  }
}
