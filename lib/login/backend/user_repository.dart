import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const String _tokenStorageKey = "api_token";

  Future<void> init() async {
    await _getTokenFromStorage();
  }

  Future<void> _getTokenFromStorage() async {
    final storage = await SharedPreferences.getInstance();
    _token = storage.getString(_tokenStorageKey);
  }

  Future<void> _saveTokenToStorage(String token) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(_tokenStorageKey, token);
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
    final storage = await SharedPreferences.getInstance();
    _token = null;
    await storage.remove(_tokenStorageKey);
  }
}
