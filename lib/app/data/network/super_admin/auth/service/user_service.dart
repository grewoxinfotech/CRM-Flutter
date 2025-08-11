import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';

class UserService {
  // Get user data from storage
  Future<UserModel?> getUserData() async {
    try {
      return await SecureStorage.getUserData();
    } catch (e) {
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn = await SecureStorage.getLoggedIn();
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();
      
      return isLoggedIn && token != null && userData != null;
    } catch (e) {
      return false;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await SecureStorage.clearAll();
    } catch (e) {
      // Handle logout error
    }
  }
}
