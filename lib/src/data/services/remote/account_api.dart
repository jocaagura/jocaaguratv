import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';
import '../local/session_service.dart';
import '../utils/handle_failure.dart';

class AccountApi {
  AccountApi(
    this._http,
    this._sessionService,
  );

  final Http _http;
  final SessionService _sessionService;

  Future<UserModel?> getAccount(String sessionId) async {
    final Either<HttpFailure, UserModel> result = await _http.request(
      '3/account',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'session_id': sessionId,
      },
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );

        return UserModel.fromJson(json);
      },
    );
    return result.when((_) => null, (UserModel user) => user);
  }

  Future<Either<HttpRequestFailure, Map<int, MediaModel>>> getFavorites(
    MediaType mediaType,
  ) async {
    final String accountId = await _sessionService.accountId ?? '';
    final Either<HttpFailure, Map<int, MediaModel>> result =
        await _http.request(
      '3/account/$accountId/favorite/${mediaType == MediaType.movie ? "movies" : "tv"}',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'session_id': await _sessionService.sessionId ?? '',
      },
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );
        final Map<int, MediaModel> map = <int, MediaModel>{};

        final List<Json> list = <Json>[];
        for (final dynamic element in json['results'] as List<dynamic>) {
          (element as Json)['media_type'] = mediaType.name;
          list.add(element);
        }

        final Iterable<MapEntry<int, MediaModel>> iterable =
            list.map((Json mediaModelJson) {
          final MediaModel mediaModel = MediaModel.fromJson(mediaModelJson);
          return MapEntry<int, MediaModel>(mediaModel.id, mediaModel);
        });
        map.addEntries(iterable);
        return map;
      },
    );
    return result.when(
      handleFailure,
      (Map<int, MediaModel> value) =>
          Right<HttpRequestFailure, Map<int, MediaModel>>(value),
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType mediaType,
    required bool isFavorite,
  }) async {
    final String accountId = await _sessionService.accountId ?? '';
    final String sessionId = await _sessionService.sessionId ?? '';
    final Either<HttpFailure, void> result = await _http.request(
      '3/account/$accountId/favorite',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'session_id': sessionId,
      },
      body: <String, dynamic>{
        'media_type': mediaType.name,
        'media_id': mediaId,
        'favorite': isFavorite,
      },
      httpMethod: HttpMethod.post,
      onSuccess: (_) {
        return;
      },
    );
    return result.when(handleFailure, (_) {
      return const Right<HttpRequestFailure, void>(null);
    });
  }
}
