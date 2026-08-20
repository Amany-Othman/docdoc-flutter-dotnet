import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'jwt_token';

  // ---- Generic methods (use for any string value) ----

  static Future<void> saveValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // ---- Convenience wrappers for the JWT token ----

  static Future<void> saveToken(String token) => saveValue(_tokenKey, token);

  static Future<String?> getToken() => getValue(_tokenKey);

  static Future<void> deleteToken() => deleteValue(_tokenKey);
}
