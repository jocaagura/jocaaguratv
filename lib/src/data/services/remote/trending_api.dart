import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';

const Map<TimeWindow, String> kTimeWindowMap = <TimeWindow, String>{
  TimeWindow.day: 'day',
  TimeWindow.week: 'week',
};

class TrendingApi {
  TrendingApi(this._http);

  final Http _http;

  Future<Either<HttpFailure, List<MediaModel>>> getMoviesSeries(
      TimeWindow timeWindow) {
    return _http.request(
      '3/trending/all/${timeWindow.name}',
      onSuccess: (String json) {
        final Json jsonB = jsonDecode(json) as Json;
        final List<Json> list = jsonB['result'] as List<Json>;
        return list
            .where((Json e) => e['media_Type'] != 'person')
            .map((Json item) => MediaModel.fromJson(item))
            .toList();
      },
    );
  }
}
