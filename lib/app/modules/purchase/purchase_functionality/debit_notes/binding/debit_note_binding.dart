import 'package:crm_flutter/app/modules/purchase/purchase_functionality/debit_notes/controller/debit_note_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


class DebitNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebitNoteController>(() => DebitNoteController());
  }
}
