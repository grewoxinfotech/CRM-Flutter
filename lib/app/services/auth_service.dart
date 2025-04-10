import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = 'authToken';
  static const _keyUsername = 'username';
  static const _keyRememberMe = 'rememberMe';

  // Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  // Username
  static Future<void> saveUsername(String username) async {
    await _storage.write(key: _keyUsername, value: username);
  }

  static Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  // Remember Me
  static Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: _keyRememberMe, value: value.toString());
  }

  static Future<bool> getRememberMe() async {
    String? value = await _storage.read(key: _keyRememberMe);
    return value == 'true';
  }

  // Clear all
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
