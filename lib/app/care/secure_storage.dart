
class SecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _tokenKey = "auth_token";
  static const _userKey = "user_data";


  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }


  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }


  static Future<void> saveUserData(String userData) async {
    await _storage.write(key: _userKey, value: userData);
  }


  static Future<String?> getUserData() async {
    return await _storage.read(key: _userKey);
  }


  static Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}
