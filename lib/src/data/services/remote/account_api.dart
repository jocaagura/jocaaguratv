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
        'session_id': await _sessionService.sessionId ?? '',
      },
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );
        final List<Json> list = json['results'] as List<Json>;
        final Iterable<MapEntry<int, MediaModel>> iterable =
            list.map((Json mediaModelJson) {
          final MediaModel mediaModel = MediaModel.fromJson(mediaModelJson);
          return MapEntry<int, MediaModel>(mediaModel.id, mediaModel);
        });
        final Map<int, MediaModel> map = <int, MediaModel>{};
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
}
