import '../either.dart';
import '../enums.dart';
import '../failures/http_requets/http_request_failure.dart';
import '../models/media/media_model.dart';
import '../models/performer/performer.dart';

abstract class TrendingRepository {
  Future<Either<HttpRequestFailure, List<MediaModel>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  );
  Future<Either<HttpRequestFailure, List<PerformerModel>>> getPerformers();
}
