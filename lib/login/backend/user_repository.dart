import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static const String _tokenStorageKey = "api_token";
  final storage = FlutterSecureStorage();

  Future<void> init() async {
    await _getTokenFromStorage();
  }

  Future<void> _getTokenFromStorage() async {
    _token = await storage.read(key: _tokenStorageKey);
  }

  Future<void> _saveTokenToStorage(String token) async {
    await storage.write(key: _tokenStorageKey, value: token);
  }

  String _token;

  bool get isLoggedIn => _token != null;

  // Returns if operation was successful or not
  Future<bool> login(String username, String password) async {
    if (username.isNotEmpty && password == "123") {
      _token = "secretToken";
      await _saveTokenToStorage(_token);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _token = null;
    await storage.delete(key: _tokenStorageKey);
  }
}
