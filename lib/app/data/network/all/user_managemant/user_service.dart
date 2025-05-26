import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/all/user_managemant/user_model.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<UserService> init() async {
    user.value = await SecureStorage.getUserData();
    return this;
  }
}
