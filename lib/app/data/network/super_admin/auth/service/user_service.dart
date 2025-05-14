import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:get/get.dart';

class UserService extends GetConnect {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    print("UserService: Initializing...");
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      print("UserService: Getting user data from storage...");
      final userData = await SecureStorage.getUserData();
      if (userData != null) {
        print("UserService: User data found");
        print("UserService: User ID: ${userData.id}");
        print("UserService: Username: ${userData.username}");
        user.value = userData;
      } else {
        print("UserService: No user data found in storage");
        user.value = null;
      }
    } catch (e) {
      print("UserService: Error getting user data: $e");
      user.value = null;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      print("UserService: Checking login status...");
      final isLoggedIn = await SecureStorage.getLoggedIn();
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();
      
      print("UserService: Login status: $isLoggedIn");
      print("UserService: Token exists: ${token != null}");
      print("UserService: User data exists: ${userData != null}");
      
      return isLoggedIn && token != null && userData != null;
    } catch (e) {
      print("UserService: Error checking login status: $e");
      return false;
    }
  }

  Future<void> logout() async {
    try {
      print("UserService: Logging out...");
      await SecureStorage.clearAll();
      user.value = null;
      print("UserService: Logout successful");
    } catch (e) {
      print("UserService: Error during logout: $e");
    }
  }
}
