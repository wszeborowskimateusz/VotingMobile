import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/http/http_status_exception.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_authentication_api.dart';
import 'package:votingmobile/login/backend/user_repository.dart';

class UserAuthenticationApiMock extends Mock implements UserAuthenticationApi {}

class CommonHttpClientMock extends Mock implements CommonHttpClient {}

void main() {
  final UserAuthenticationApi userAuthenticationApi = UserAuthenticationApiMock();
  final CommonHttpClient commonHttpClient = CommonHttpClientMock();

  setUpAll(() {
    locator.registerLazySingleton<UserAuthenticationApi>(() => userAuthenticationApi);
    locator.registerLazySingleton<CommonHttpClient>(() => commonHttpClient);
  });

  test("is logged in should call http client", () async {
    final UserRepository repository = UserRepository();

    repository.isLoggedIn;

    verify(commonHttpClient.token).called(1);
  });

  test("login should call userAuthenticationApi", () async {
    final UserRepository repository = UserRepository();
    final newToken = "new token";

    when(userAuthenticationApi.login(any)).thenAnswer((_) async => newToken);

    final result = await repository.login("username", "password");

    verify(commonHttpClient.updateToken(newToken)).called(1);
    expect(result, LoginStatus.successful);
  });

  test("login should handle no session exception", () async {
    final UserRepository repository = UserRepository();

    when(userAuthenticationApi.login(any))
        .thenAnswer((_) => Future.error(HttpStatusException(404, 'IN_PROGRESS/SUSPENDED')));

    final result = await repository.login("username", "password");

    expect(result, LoginStatus.noSession);
  });

  test("login should handle user blocked exception", () async {
    final UserRepository repository = UserRepository();

    when(userAuthenticationApi.login(any))
        .thenAnswer((_) => Future.error(HttpStatusException(401, 'BLOCKED')));

    final result = await repository.login("username", "password");

    expect(result, LoginStatus.userBlocked);
  });

  test("login should handle wrong username or password exception", () async {
    final UserRepository repository = UserRepository();

    when(userAuthenticationApi.login(any))
        .thenAnswer((_) => Future.error(HttpStatusException(500, 'ANYTHING')));

    final result = await repository.login("username", "password");

    expect(result, LoginStatus.wrongUsernameOrPassword);
  });

  test("logout should call httpClient and userAuthenticationApi when user is logged in", () async {
    final UserRepository repository = UserRepository();

    when(commonHttpClient.token).thenReturn("some token");

    await repository.logout();

    verify(commonHttpClient.updateToken(null)).called(1);
    verify(userAuthenticationApi.logout()).called(1);
  });

  test("logout should not call httpClient and userAuthenticationApi when user is not logged in",
      () async {
    final UserRepository repository = UserRepository();

    when(commonHttpClient.token).thenReturn(null);

    await repository.logout();

    verifyNever(commonHttpClient.updateToken(null));
    verifyNever(userAuthenticationApi.logout());
  });
}
