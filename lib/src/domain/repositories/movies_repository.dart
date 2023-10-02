import '../either.dart';
import '../failures/http_requets/http_request_failure.dart';
import '../models/movie/movie_model.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, MovieModel>> getMovieById(int id);
}
