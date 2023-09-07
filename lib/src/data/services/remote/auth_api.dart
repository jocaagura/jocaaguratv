import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../domain/either.dart';
import '../../../domain/enums.dart';

const String kBaseUrl = 'api.themoviedb.org';
const String kApiKey = 'df3952a67d9b47d7968f2d67a4d2f2a2';

class AuthApi {
  const AuthApi(this._client);
  final http.Client _client;

  Future<String?> createRequestToken() async {
    try {
      final http.Response response = await _client.get(
        Uri(
          host: kBaseUrl,
          scheme: 'https',
          path: '3/authentication/token/new',
          queryParameters: <String, String>{'api_key': kApiKey},
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(response.body) as Map<dynamic, dynamic>,
        );
        return json['request_token'].toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print('🤦‍♀️ Error: $e');
      }
    }
    return null;
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final http.Response response = await _client.post(
        Uri(
          host: kBaseUrl,
          scheme: 'https',
          path: '3/authentication/token/validate_with_login',
          queryParameters: <String, String>{
            'api_key': kApiKey,
          },
        ),
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'request_token': requestToken,
        }),
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> json = Map<String, dynamic>.from(
            jsonDecode(response.body) as Map<dynamic, dynamic>,
          );
          return Right<SignInFailure, String>(json['request_token'].toString());
        case 401:
          return const Left<SignInFailure, String>(SignInFailure.unauthorized);
        case 404:
          return const Left<SignInFailure, String>(SignInFailure.notFound);

        default:
          return const Left<SignInFailure, String>(SignInFailure.unknow);
      }
    } catch (e) {
      if (e is SocketException) {
        return const Left<SignInFailure, String>(SignInFailure.network);
      }
      if (kDebugMode) {
        print('🤦‍♀️ Error: $e');
      }
    }
    return const Left<SignInFailure, String>(SignInFailure.unknow);
  }

  Future<Either<SignInFailure, String>> createSession(
    String requestToken,
  ) async {
    try {
      final http.Response response = await _client.post(
        Uri(
          host: kBaseUrl,
          scheme: 'https',
          path: '3/authentication/session/new',
          queryParameters: <String, String>{
            'api_key': kApiKey,
          },
        ),
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'request_token': requestToken,
        }),
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> json = Map<String, dynamic>.from(
            jsonDecode(response.body) as Map<dynamic, dynamic>,
          );
          return Right<SignInFailure, String>(json['session_id'].toString());
        case 401:
          return const Left<SignInFailure, String>(SignInFailure.unauthorized);
        case 404:
          return const Left<SignInFailure, String>(SignInFailure.notFound);

        default:
          return const Left<SignInFailure, String>(SignInFailure.unknow);
      }
    } catch (e) {
      if (e is SocketException) {
        return const Left<SignInFailure, String>(SignInFailure.network);
      }
      if (kDebugMode) {
        print('🤦‍♀️ Error: $e');
      }
    }
    return const Left<SignInFailure, String>(SignInFailure.unknow);
  }
}
