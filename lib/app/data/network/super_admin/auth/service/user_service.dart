import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:get/get.dart';

class UserService extends GetConnect {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> getUserData() async {
    user.value = await SecureStorage.getUserData();
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
}
