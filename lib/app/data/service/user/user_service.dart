import 'package:crm_flutter/app/data/models/user_model/user_model.dart';
import 'package:crm_flutter/app/data/service/storage/secure_storage_service.dart';
import 'package:get/get.dart';

class UserService extends GetConnect {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> getUserData() async {
    user.value = await SecureStorage.getUserData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }
}
