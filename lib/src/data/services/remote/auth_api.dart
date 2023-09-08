import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../http/http.dart';

const String kBaseUrl = 'api.themoviedb.org';

class AuthApi {
  const AuthApi(this._http);

  final Http _http;

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final Either<HttpFailure, String> result =
        await _http.request('3/authentication/token/new');
    return result.when((HttpFailure httpFailure) {
      if (httpFailure.exception != null) {
        return const Left<SignInFailure, String>(SignInFailure.network);
      }
      return const Left<SignInFailure, String>(SignInFailure.unknow);
    }, (String responseBody) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(
        jsonDecode(responseBody) as Map<dynamic, dynamic>,
      );
      return Right<SignInFailure, String>(
        json['request_token']?.toString() ?? '',
      );
    });
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final Either<HttpFailure, String> result = await _http.request(
      '3/authentication/token/validate_with_login',
      httpMethod: HttpMethod.post,
      body: <String, String>{
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    return result.when((HttpFailure httpFailure) {
      return _httpFailure(httpFailure);
    }, (String response) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(
        jsonDecode(response) as Map<dynamic, dynamic>,
      );
      return Right<SignInFailure, String>(json['request_token'].toString());
    });
  }

  Future<Either<SignInFailure, String>> createSession(
    String requestToken,
  ) async {
    final Either<HttpFailure, String> result = await _http.request(
      '3/authentication/session/new',
      httpMethod: HttpMethod.post,
      body: <String, String>{
        'request_token': requestToken,
      },
    );
    return result.when((HttpFailure httpFailure) {
      return _httpFailure(httpFailure);
    }, (String responseBody) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(
        jsonDecode(responseBody) as Map<dynamic, dynamic>,
      );
      return Right<SignInFailure, String>(
        json['session_id'].toString(),
      );
    });
  }

  Either<SignInFailure, String> _httpFailure(HttpFailure httpFailure) {
    print('DEVOLVIENDO AQUI');
    print(httpFailure.exception);
    print(httpFailure.statusCode);
    if (httpFailure.exception != null) {
      return const Left<SignInFailure, String>(SignInFailure.network);
    }
    switch (httpFailure.statusCode) {
      case 401:
        return const Left<SignInFailure, String>(SignInFailure.unauthorized);
      case 404:
        return const Left<SignInFailure, String>(SignInFailure.notFound);
      default:
        return const Left<SignInFailure, String>(SignInFailure.unknow);
    }
  }
}
