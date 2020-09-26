import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_authentication_api.dart';
import 'package:votingmobile/login/dto/user_credentials.dart';

class UserRepository {
  final UserAuthenticationApi _userAuthenticationApi = locator.get();
  final CommonHttpClient _httpClient = locator.get();

  bool get isLoggedIn => _httpClient.token != null;

  // Returns if operation was successful or not
  Future<bool> login(String username, String password) async {
    return _userAuthenticationApi
        .login(UserCredentials(login: username, password: password))
        .then((token) {
      _httpClient.updateToken(token);
      return true;
    }).catchError((_) => false);
  }

  Future<void> logout() async {
    if (isLoggedIn) {
      await _userAuthenticationApi.logout();
      await _httpClient.updateToken(null);
    }
  }
}
