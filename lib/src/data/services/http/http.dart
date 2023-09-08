import 'dart:convert';
import 'dart:io';

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
  Future<Either<HttpFailure, String>> request(
    String path, {
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
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right<HttpFailure, String>(response.body);
      }
      return Left<HttpFailure, String>(
        HttpFailure(
          statusCode: response.statusCode,
        ),
      );
    } catch (e) {
      if (e is SocketException || e is http.ClientException) {
        print('🤦‍♀️ Error en red $e');
        return Left<HttpFailure, String>(
          HttpFailure(exception: NetworkException()),
        );
      }
      return Left<HttpFailure, String>(
        HttpFailure(exception: e),
      );
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
