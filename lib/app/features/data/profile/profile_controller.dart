import 'package:crm_flutter/app/care/secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString username = "".obs;

  Future<void> fetchUsername() async {
    final storedUsername = await SecureStorage.getUsername();
    if (storedUsername != null) {
      username.value = storedUsername;
    }
  }
}
