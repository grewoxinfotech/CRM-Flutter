import 'package:crm_flutter/app/care/service/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/models/user/user/user_model.dart';
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
