import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crm_flutter/app/data/network/all/user_managemant/user_model.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys
  static const _keyToken = 'authToken';
  static const _keyUsername = 'username';
  static const _keyRememberMe = 'rememberMe';
  static const _keyLoggedIn = 'isLogin';
  static const _keyUserData = 'user';

  /// Save JWT token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  /// Get JWT token
  static Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  /// Delete token
  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  /// Save user data (as JSON string)
  static Future<void> saveUserData(UserModel data) async {
    final jsonString = jsonEncode(data.toJson());
    await _storage.write(key: _keyUserData, value: jsonString);
  }

  /// Get user data (from JSON string)
  static Future<UserModel?> getUserData() async {
    final jsonString = await _storage.read(key: _keyUserData);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  /// Delete user data
  static Future<void> deleteUserData() async {
    await _storage.delete(key: _keyUserData);
  }

  /// Save username (optional usage)
  static Future<void> saveUsername(String username) async {
    await _storage.write(key: _keyUsername, value: username);
  }

  /// Get saved username
  static Future<String?> getUsername() async {
    return _storage.read(key: _keyUsername);
  }

  /// Delete saved username
  static Future<void> deleteUsername() async {
    await _storage.delete(key: _keyUsername);
  }

  /// Save login status
  static Future<void> saveLoggedIn(bool value) async {
    await _storage.write(key: _keyLoggedIn, value: value.toString());
  }

  /// Check login status
  static Future<bool> getLoggedIn() async {
    final value = await _storage.read(key: _keyLoggedIn);
    return value?.toLowerCase() == "true";
  }

  /// Remove login status
  static Future<void> deleteLoggedIn() async {
    await _storage.delete(key: _keyLoggedIn);
  }

  /// Save Remember Me preference
  static Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: _keyRememberMe, value: value.toString());
  }

  /// Get Remember Me preference
  static Future<bool> getRememberMe() async {
    final value = await _storage.read(key: _keyRememberMe);
    return value?.toLowerCase() == 'true';
  }

  /// Delete Remember Me preference
  static Future<void> deleteRememberMe() async {
    await _storage.delete(key: _keyRememberMe);
  }

  /// Clear all stored data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
