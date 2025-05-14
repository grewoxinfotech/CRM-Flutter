import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/crm/file/controllers/file_controller.dart';

class FileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileController>(() => FileController());
  }
}
