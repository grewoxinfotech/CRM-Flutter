import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _tokenKey = "auth_token";
  static const _usernameKey = "username";
  static const _rememberMeKey = "remember_me";
  static const _userKey = "user_data";

  // Save token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Save username/email
  static Future<void> saveUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  // Get username/email
  static Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  // Save remember me flag
  static Future<void> saveRememberMe(bool remember) async {
    await _storage.write(key: _rememberMeKey, value: remember.toString());
  }

  // Get remember me flag
  static Future<bool> getRememberMe() async {
    String? value = await _storage.read(key: _rememberMeKey);
    return value == 'true';
  }

  // Save full user data (if needed)
  static Future<void> saveUserData(String userData) async {
    await _storage.write(key: _userKey, value: userData);
  }

  // Get full user data (if needed)
  static Future<String?> getUserData() async {
    return await _storage.read(key: _userKey);
  }

  // Clear all
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
