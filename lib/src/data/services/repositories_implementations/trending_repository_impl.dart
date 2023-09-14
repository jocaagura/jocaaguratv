import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/models/performer/performer.dart';
import '../../../domain/repositories/trending_repository.dart';
import '../remote/trending_api.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  TrendingRepositoryImpl(this._trendingApi);

  final TrendingApi _trendingApi;

  @override
  Future<Either<HttpRequestFailure, List<MediaModel>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) {
    return _trendingApi.getMoviesSeries(timeWindow);
  }

  @override
  Future<Either<HttpRequestFailure, List<PerformerModel>>> getPerformers() {
    return _trendingApi.getPerformers(TimeWindow.day);
  }
}
