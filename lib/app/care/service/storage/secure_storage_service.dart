import 'dart:convert';

import 'package:crm_flutter/app/data/models/user/user/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys
  static const String _keyToken = 'authToken';
  static const String _keyUsername = 'username';
  static const String _keyRememberMe = 'rememberMe';
  static const String _keyLoggedIn = 'islogin';
  static const String _KeyUserData = 'user';

  // Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token.toString());
  }

  static Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  // user data
  static Future<void> saveUserData(UserModel data) async {
    return await _storage.write(
      key: _KeyUserData,
      value: jsonEncode(data.toJson()),
    );
  }

  static Future<UserModel?> getUserData() async {
    final jsonString = await _storage.read(key: _KeyUserData);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString); // ✅ convert string to map
    return UserModel.fromJson(jsonMap);
  }


  static Future<void> deleteUserData() async {
    await _storage.delete(key: _KeyUserData);
  }

  // Username
  static Future<void> saveUsername(String username) async {
    await _storage.write(key: _keyUsername, value: username);
  }

  static Future<String?> getUsername() async {
    return _storage.read(key: _keyUsername);
  }


  static Future<void> deleteUsername() async {
    await _storage.delete(key: _keyUsername);
  }

  // isLoggedIn
  static Future<void> saveLoggedIn(bool value) async {
    await _storage.write(key: _keyLoggedIn, value: value.toString());
  }

  static Future<bool> getLoggedIn() async {
    final value = await _storage.read(key: _keyLoggedIn);
    return value?.toLowerCase() == "true";
  }

  static Future<void> deleteLoggedIn() async {
    await _storage.delete(key: _keyLoggedIn);
  }

  // Remember Me
  static Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: _keyRememberMe, value: value.toString());
  }

  static Future<bool> getRememberMe() async {
    final value = await _storage.read(key: _keyRememberMe);
    return value?.toLowerCase() == 'true';
  }

  static Future<void> deleteRememberMe() async {
    await _storage.delete(key: _keyRememberMe);
  }

  // Clear everything
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
