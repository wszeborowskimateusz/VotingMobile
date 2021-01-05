import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/http/http_status_exception.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:votingmobile/nav_key.dart';

part '_http_client_token_manager.dart';

typedef ResponseParser<T> = T Function(dynamic json);

class CommonHttpClient {
  final Config _config = locator.get();
  final HttpClientTokenManager _tokenManager = HttpClientTokenManager();

  Future<void> init() async {
    await _tokenManager.init();
  }

  Future<void> updateToken(String newToken) {
    return _tokenManager.updateToken(newToken);
  }

  String get token => _tokenManager.token;

  Future<T> get<T>({String url, ResponseParser<T> responseParser}) async {
    final response = await http
        .get(_prepareApiUrl(url), headers: _commonHeaders())
        .catchError(_handleError);

    return _parseResponse(response, parser: responseParser)
        .catchError(_handleError);
  }

  Future<T> post<T>({
    @required String url,
    Map<String, dynamic> body,
    ResponseParser<T> responseParser,
    bool handle401 = true,
  }) async {
    final response = await (http
        .post(_prepareApiUrl(url),
            headers: _commonHeaders(withContentType: body != null),
            body: body == null ? null : json.encode(body))
        .catchError((error) {
      _handleError(error);
    }));

    return _parseResponse(response,
            parser: responseParser, handle401: handle401)
        .catchError((error) {
      _handleError(error);
    });
  }

  String _prepareApiUrl(String url) {
    return '${_config.apiUrl}$url';
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
    ResponseParser<T> parser,
    bool handle401 = true,
  }) async {
    final String refreshedToken = response.headers["Refreshed-Jwt-Token"];
    if (refreshedToken != null) {
      await updateToken(refreshedToken);
    }

    if (response.statusCode == 401 && handle401) {
      await locator.get<UserRepository>().logout();
      navigateToHomePage(navigatorKey.currentContext);
      return null;
    }

    if (response.statusCode ~/ 200 != 1) {
      throw HttpStatusException(response.statusCode, response.body);
    }

    final String data = response.body;

    if (data == null || data.isEmpty || parser == null) {
      return null;
    }

    final jsonResponse = json.decode(data);

    return parser(jsonResponse);
  }

  void _handleError(error) {
    print(error);

    // TODO: Do something with the error ?
    throw error;
  }
}
