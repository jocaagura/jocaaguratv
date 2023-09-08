import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../domain/either.dart';

const String kApiKey = 'df3952a67d9b47d7968f2d67a4d2f2a2';

class Http {
  Http(
    this._baseUrl,
    this._client,
  );

  final http.Client _client;
  final String _baseUrl;
  Future<Either<HttpFailure, R>> request<R>(
    String path, {
    required R Function(String responseBody) onSuccess,
    HttpMethod httpMethod = HttpMethod.get,
    Map<String, String> headers = const <String, String>{
      'Content-type': 'application/json',
    },
    Map<String, String> queryParameters = const <String, String>{
      'api_key': kApiKey,
    },
    Map<String, dynamic> body = const <String, dynamic>{},
  }) async {
    late final http.Response response;
    final String bodyString = jsonEncode(body);
    final Uri url = Uri(
      host: _baseUrl,
      scheme: 'https',
      path: path,
      queryParameters: queryParameters,
    );
    final Map<String, dynamic> logs = <String, dynamic>{};
    try {
      switch (httpMethod) {
        case HttpMethod.get:
          response = await _client.get(url, headers: headers);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right<HttpFailure, R>(onSuccess(response.body));
      }
      logs['startDate'] = DateTime.now().toString();
      logs['url'] = url.toString();
      logs['method'] = httpMethod;
      logs['body'] = body;
      logs['status code'] = response.statusCode;
      logs['response body'] = response.body;
      return Left<HttpFailure, R>(
        HttpFailure(
          statusCode: response.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      if (e is SocketException || e is http.ClientException) {
        logs['exception'] = 'Network Exception';
        if (kDebugMode) {
          print('🤦‍♀️ Error en red ($stackTrace): $e');
        }
        return Left<HttpFailure, R>(
          HttpFailure(exception: NetworkException()),
        );
      }
      logs['exception'] = e;
      logs['stackTrace'] = stackTrace.toString();
      return Left<HttpFailure, R>(
        HttpFailure(exception: e),
      );
    } finally {
      if (logs.isNotEmpty) {
        if (kDebugMode) {
          logs['endDate'] = DateTime.now().toString();
          print('🤦‍♀️ Error : $logs');
        }
      }
    }
  }
}

class HttpFailure {
  HttpFailure({
    this.statusCode,
    this.exception,
  });

  final int? statusCode;
  final Object? exception;
}

class NetworkException {}

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}
