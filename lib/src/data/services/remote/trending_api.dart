import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/models/performer/performer.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';
import '../local/langage_service.dart';
import '../utils/handle_failure.dart';

const Map<TimeWindow, String> kTimeWindowMap = <TimeWindow, String>{
  TimeWindow.day: 'day',
  TimeWindow.week: 'week',
};

class TrendingApi {
  TrendingApi(this._http, this._languageService);

  final Http _http;
  final LanguageService _languageService;

  Future<Either<HttpRequestFailure, List<MediaModel>>> getMoviesSeries(
    TimeWindow timeWindow,
  ) async {
    final Either<HttpFailure, List<MediaModel>> result = await _http.request(
      '3/trending/all/${timeWindow.name}',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'language': _languageService.languageCode,
      },
      onSuccess: (String json) {
        final Json jsonB = jsonDecode(json) as Json;
        final List<Json> list =
            List<Json>.from(jsonB['results'] as Iterable<dynamic>);
        return list
            .where(
              (Json e) => e['media_Type'] != 'person',
            )
            .map((Json item) => MediaModel.fromJson(item))
            .toList();
      },
    );
    return result.when(
      handleFailure,
      (List<MediaModel> listMedia) =>
          Right<HttpRequestFailure, List<MediaModel>>(listMedia),
    );
  }

  Future<Either<HttpRequestFailure, List<PerformerModel>>> getPerformers(
    TimeWindow timeWindow,
  ) async {
    final Either<HttpFailure, List<PerformerModel>> result =
        await _http.request(
      '3/trending/person/${timeWindow.name}',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'language': _languageService.languageCode,
      },
      onSuccess: (String json) {
        final Json jsonB = jsonDecode(json) as Json;
        final List<Json> list =
            List<Json>.from(jsonB['results'] as Iterable<dynamic>);
        return list
            .where(
              (Json e) => e['known_for_department'] == 'Acting',
            )
            .map((Json item) => PerformerModel.fromJson(item))
            .toList();
      },
    );
    return result.when(
      handleFailure,
      (List<PerformerModel> listPerformer) =>
          Right<HttpRequestFailure, List<PerformerModel>>(listPerformer),
    );
  }
}
