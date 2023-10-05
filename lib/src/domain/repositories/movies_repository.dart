import '../either.dart';
import '../failures/http_requets/http_request_failure.dart';
import '../models/movie/movie_model.dart';
import '../models/performer/performer.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, MovieModel>> getMovieById(int id);
  Future<Either<HttpRequestFailure, List<PerformerModel>>> getCastByMovieId(
    int id,
  );
}
