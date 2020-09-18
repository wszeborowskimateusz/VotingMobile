import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:http/http.dart' as http;

part '_http_client_token_manager.dart';

typedef ResponseParser<T> = T Function(Map<String, dynamic> json);

class CommonHttpClient {
  final HttpClientTokenManager _tokenManager = HttpClientTokenManager();

  Future<void> init() async {
    await _tokenManager.init();
  }

  Future<void> updateToken(String newToken) {
    return _tokenManager.updateToken(newToken);
  }

  String get token => _tokenManager.token;

  Future<T> get<T>({String url, ResponseParser responseParser}) async {
    final response = await http
        .get(_prepareApiUrl(url), headers: _commonHeaders())
        .catchError(_handleError);

    return _parseResponse(response, parser: responseParser).catchError(_handleError);
  }

  Future<T> post<T>({
    @required String url,
    Map<String, dynamic> body,
    ResponseParser responseParser,
  }) async {
    final response = await (http
        .post(_prepareApiUrl(url),
            headers: _commonHeaders(withContentType: body != null),
            body: json.encode(body))
        .catchError(_handleError));

    return _parseResponse(response, parser: responseParser).catchError((Object error) {
      _handleError(error);
    });
  }

  Uri _prepareApiUrl(String url) {
    return Uri.parse('${Config.apiUrl}$url');
  }

  Map<String, String> _commonHeaders({bool withContentType = false}) {
    Map<String, String> headers = {
      if (withContentType)
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    if (_tokenManager.token != null) {
      headers[HttpHeaders.authorizationHeader] =
          'Bearer ${_tokenManager.token}';
    }

    return headers;
  }

  Future<T> _parseResponse<T>(
    http.Response response, {
    ResponseParser parser,
  }) async {
    final String refreshedToken = response.headers["Refreshed-Jwt-Token"];
    if (refreshedToken != null) {
      await updateToken(refreshedToken);
    }

    if (response.statusCode == 401) {
      //TODO: Navigate to starting page
      await locator.get<UserRepository>().logout();
    }

    if (response.statusCode ~/ 200 != 1) {
      print(response.statusCode);
      print(response.reasonPhrase);
      throw HttpException(response.reasonPhrase);
    }

    final String data = response.body;

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
