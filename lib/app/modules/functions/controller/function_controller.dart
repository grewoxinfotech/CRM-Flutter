import 'package:crm_flutter/app/data/network/function/model/function_model.dart';
import 'package:get/get.dart';

class FunctionController extends GetxController {
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }
}
