import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';

import '../controllers/note_controller.dart';

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteService>(() => NoteService());
    Get.lazyPut<NoteController>(() => NoteController());
  }
}
