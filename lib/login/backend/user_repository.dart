import 'dart:io';

import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/http/http_status_exception.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_authentication_api.dart';
import 'package:votingmobile/login/dto/user_credentials.dart';

enum LoginStatus { successful, wrongUsernameOrPassword, noSession, userBlocked }

class UserRepository {
  final UserAuthenticationApi _userAuthenticationApi = locator.get();
  final CommonHttpClient _httpClient = locator.get();

  bool get isLoggedIn => _httpClient.token != null;

  // Returns if operation was successful or not
  Future<LoginStatus> login(String username, String password) async {
    return _userAuthenticationApi
        .login(UserCredentials(login: username, password: password))
        .then((token) {
      _httpClient.updateToken(token);
      return LoginStatus.successful;
    }).catchError((error) {
      // TODO: Check where the message is
      if (error is HttpStatusException) {
        if (error.statusCode == 404 &&
            error.reasonPhrase == 'IN_PROGRESS/SUSPENDED') {
          return LoginStatus.noSession;
        }

        if (error.statusCode == 401 && error.reasonPhrase == 'BLOCKED') {
          return LoginStatus.userBlocked;
        }
      }

      return LoginStatus.wrongUsernameOrPassword;
    });
  }

  Future<void> logout() async {
    if (isLoggedIn) {
      await _userAuthenticationApi.logout();
      await _httpClient.updateToken(null);
    }
  }
}
