import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../http/http.dart';

const String kBaseUrl = 'api.themoviedb.org';

class AuthApi {
  const AuthApi(this._http);

  final Http _http;

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final Either<HttpFailure, String> result = await _http.request(
      '3/authentication/token/new',
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );
        return json['request_token']?.toString() ?? '';
      },
    );
    return result.when(_httpFailure, (String requestToken) {
      return Right<SignInFailure, String>(
        requestToken,
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
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );
        return json['request_token'].toString();
      },
      httpMethod: HttpMethod.post,
      body: <String, String>{
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    return result.when(_httpFailure, (String newRequestToken) {
      return Right<SignInFailure, String>(newRequestToken);
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
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );
        return json['session_id'].toString();
      },
    );
    return result.when(_httpFailure, (String sesionId) {
      return Right<SignInFailure, String>(sesionId);
    });
  }

  Either<SignInFailure, String> _httpFailure(HttpFailure httpFailure) {
    if (httpFailure.exception != null) {
      return const Left<SignInFailure, String>(SignInFailure.network);
    }
    switch (httpFailure.statusCode) {
      case 401:
        if (httpFailure.data is Map) {
          return const Left<SignInFailure, String>(
            SignInFailure.emailNotVerified,
          );
        }
        return const Left<SignInFailure, String>(SignInFailure.unauthorized);
      case 404:
        return const Left<SignInFailure, String>(SignInFailure.notFound);
      default:
        return const Left<SignInFailure, String>(SignInFailure.unknow);
    }
  }
}
