part of 'http_client.dart';

class HttpClientTokenManager {
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
  String get token => _token;

  Future<void> updateToken(String newToken) async {
    _token = newToken;
    await _saveTokenToStorage(_token);
  }
}
