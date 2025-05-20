import 'package:get/get.dart';

class CrmDrawerController extends GetxController {
  RxInt selextedIndex = 0.obs;

  onchange(int index) => selextedIndex(index);
}
