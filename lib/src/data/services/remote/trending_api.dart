import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';
import '../utils/handle_failure.dart';

const Map<TimeWindow, String> kTimeWindowMap = <TimeWindow, String>{
  TimeWindow.day: 'day',
  TimeWindow.week: 'week',
};

class TrendingApi {
  TrendingApi(this._http);

  final Http _http;

  Future<Either<HttpRequestFailure, List<MediaModel>>> getMoviesSeries(
    TimeWindow timeWindow,
  ) async {
    final Either<HttpFailure, List<MediaModel>> result = await _http.request(
      '3/trending/all/${timeWindow.name}',
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
}
