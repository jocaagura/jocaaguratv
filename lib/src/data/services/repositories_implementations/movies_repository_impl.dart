import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/movie/movie_model.dart';
import '../../../domain/repositories/movies_repository.dart';
import '../remote/movies_api.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this._moviesApi);

  final MoviesApi _moviesApi;
  @override
  Future<Either<HttpRequestFailure, MovieModel>> getMovieById(int id) {
    return _moviesApi.getMovieById(id);
  }
}
