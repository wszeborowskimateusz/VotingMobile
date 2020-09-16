import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/dto/user_credentials.dart';

class UserAuthenticationApi {
  final CommonHttpClient _httpClient = locator.get();

  Future<String> login(UserCredentials userCredentials) async {
    return _httpClient.post(
      url: '/authentication/login',
      body: userCredentials.toJson(),
      responseParser: (dynamic json) => json['token'],
    );
  }

  Future<void> logout() async {
    return _httpClient.post(
      url: '/authentication/logout',
    );
  }
}