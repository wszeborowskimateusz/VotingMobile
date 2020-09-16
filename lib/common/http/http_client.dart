import 'dart:convert';

import 'package:universal_io/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';

part '_http_client_token_manager.dart';

typedef ResponseParser<T> = T Function(Map<String, dynamic> json);

class CommonHttpClient {
  final HttpClient _client = HttpClient();
  final HttpClientTokenManager _tokenManager = HttpClientTokenManager();

  Future<void> init() async {
    await _tokenManager.init();
  }

  Future<void> updateToken(String newToken) {
    return _tokenManager.updateToken(newToken);
  }

  String get token => _tokenManager.token;

  Future<T> get<T>({String url, ResponseParser responseParser}) async {
    return _client
        .getUrl(_prepareApiUrl(url))
        .then((HttpClientRequest request) => _prepareRequest(request))
        .then((HttpClientResponse response) =>
            _parseResponse<T>(response, parser: responseParser))
        .catchError((error) => _handleError(error));
  }

  Future<T> post<T>({
    String url,
    Map<String, dynamic> body,
    ResponseParser responseParser,
  }) async {
    return _client
        .postUrl(_prepareApiUrl(url))
        .then(
            (HttpClientRequest request) => _prepareRequest(request, body: body))
        .then((HttpClientResponse response) => _parseResponse<T>(response))
        .catchError((error) => _handleError(error));
  }

  Uri _prepareApiUrl(String url) {
    return Uri.parse('${Config.apiUrl}$url');
  }

  Future<HttpClientResponse> _prepareRequest(HttpClientRequest request,
      {Map<String, dynamic> body}) {
    request.headers
        .add(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
    if (_tokenManager.token != null) {
      request.headers.add(
          HttpHeaders.authorizationHeader, 'Bearer ${_tokenManager.token}');
    }

    if (body != null) {
      request.write(json.encode(body));
    }
    return request.close();
  }

  Future<T> _parseResponse<T>(
    HttpClientResponse response, {
    ResponseParser parser,
  }) async {
    final String refreshedToken = response.headers.value("Refreshed-Jwt-Token");
    if (refreshedToken != null) {
      await updateToken(refreshedToken);
    }

    if (response.statusCode == 401) {
      //TODO: Navigate to starting page
      await locator.get<UserRepository>().logout();
    }

    if (response.statusCode ~/ 200 == 1) {
      throw HttpException(response.reasonPhrase);
    }

    final String data = await response.transform(utf8.decoder).join();

    if (data == null || parser == null) {
      return null;
    }

    final Map<String, dynamic> jsonResponse = json.decode(data);

    return parser(jsonResponse);
  }

  void _handleError(error) {
    print(error);

    return error;
  }
}
