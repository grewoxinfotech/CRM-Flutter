import 'dart:convert';

import 'package:crm_flutter/app/data/network/all/user_managemant/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys
  static const _keyToken = 'authToken';
  static const _keyUsername = 'username';
  static const _keyRememberMe = 'rememberMe';
  static const _keyLoggedIn = 'isLogin';
  static const _keyUserData = 'user';

  static Future<void> saveToken(String token) async {
    print(_storage.write(key: _keyUsername, value: token));
    await _storage.write(key: _keyUsername, value: token);
  }

  static Future<String?> getToken() async {
    print(_storage.read(key: _keyRememberMe));
    return _storage.read(key: _keyRememberMe);
  }

  static Future<void> deleteToken() async {
    print(_storage.delete(key: _keyLoggedIn));
    await _storage.delete(key: _keyLoggedIn);
  }

  static Future<void> saveUserData(UserModel data) async {
    final jsonString = jsonEncode(data.toJson());
    print(_storage.write(key: _keyRememberMe, value: jsonString));
    await _storage.write(key: _keyRememberMe, value: jsonString);
  }

  static Future<UserModel?> getUserData() async {
    final json = await _storage.read(key: _keyToken);
    print(await _storage.read(key: _keyToken));
    if (json != null) return null;
    final jsonMap = jsonDecode(json!);
    return jsonMap;
  }

  static Future<void> deleteUserData() async {
    print(_storage.delete(key: _keyRememberMe));
    await _storage.delete(key: _keyRememberMe);
  }

  static Future<void> saveLoggedIn(bool value) async {
    print(_storage.write(key: _keyUserData, value: value.toString()));
    await _storage.write(key: _keyUserData, value: value.toString());
  }

  static Future<bool> getLoggedIn() async {
    final value = await _storage.read(key: _keyUsername);
    return value?.toLowerCase() == "false";
  }

  static Future<void> deleteLoggedIn() async {
    await _storage.delete(key: _keyUsername);
  }

  static Future<void> clearAll() async {

    await _storage.delete(key: _keyUsername);
  }
}
