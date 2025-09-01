import 'dart:convert';

import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys
  static const String _keyToken = 'authToken';
  static const String _keyUsername = 'username';
  static const String _keyRememberMe = 'rememberMe';
  static const String _keyLoggedIn = 'isLogin';
  static const String _keyUserData = 'user';
  static const String _keyClientId = 'clientId';
  static const String _keyAttendance = 'attendance';
  static const String _keyLastPunchDate = 'lastPunchDate';
  static const String _keyPunchInDone = 'punchInDone';
  static const String _keyPunchOutDone = 'punchOutDone';

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
    await _storage.write(key: _keyUserData, value: jsonEncode(data.toJson()));
    // Also save client ID separately for easy access
    if (data.clientId != null) {
      await _storage.write(key: _keyClientId, value: data.clientId);
    }
  }

  static Future<UserModel?> getUserData() async {
    final jsonString = await _storage.read(key: _keyUserData);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  static Future<void> deleteUserData() async {
    await _storage.delete(key: _keyUserData);
    await _storage.delete(key: _keyClientId);
  }

  static Future<String?> getClientId() async {
    final clientId = await _storage.read(key: _keyClientId);
    if (clientId != null) return clientId;
    final userData = await getUserData();
    return userData?.clientId;
  }

  // Attendance
  static Future<void> saveAttendance(String attendance) async {
    await _storage.write(key: _keyAttendance, value: attendance);
  }

  static Future<String?> getAttendance() async {
    return _storage.read(key: _keyAttendance);
  }

  static Future<void> deleteAttendance() async {
    await _storage.delete(key: _keyAttendance);
  }

  // 🔹 Save last punch date (yyyy-MM-dd)
  static Future<void> saveLastPunchDate(DateTime date) async {
    final formatted = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    await _storage.write(key: _keyLastPunchDate, value: formatted);
  }

  static Future<String?> getLastPunchDate() async {
    return _storage.read(key: _keyLastPunchDate);
  }

  static Future<void> deleteLastPunchDate() async {
    await _storage.delete(key: _keyLastPunchDate);
  }

  // 🔹 Save Punch In/Out status
  static Future<void> savePunchInDone(bool value) async {
    await _storage.write(key: _keyPunchInDone, value: value.toString());
  }

  static Future<bool> getPunchInDone() async {
    final value = await _storage.read(key: _keyPunchInDone);
    return value?.toLowerCase() == 'true';
  }

  static Future<void> savePunchOutDone(bool value) async {
    await _storage.write(key: _keyPunchOutDone, value: value.toString());
  }

  static Future<bool> getPunchOutDone() async {
    final value = await _storage.read(key: _keyPunchOutDone);
    return value?.toLowerCase() == 'true';
  }

  static Future<void> resetPunchStatus() async {
    await savePunchInDone(false);
    await savePunchOutDone(false);
    await deleteLastPunchDate();
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
