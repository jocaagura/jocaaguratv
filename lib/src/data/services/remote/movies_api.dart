import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/movie/movie_model.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';
import '../utils/handle_failure.dart';

class MoviesApi {
  const MoviesApi(this._http);
  final Http _http;

  Future<Either<HttpRequestFailure, MovieModel>> getMovieById(
    int id,
  ) async {
    final Either<HttpFailure, MovieModel> result = await _http.request(
      '3/movie/$id',
      onSuccess: (String json) {
        final Json jsonB = jsonDecode(json) as Json;
        return MovieModel.fromJson(jsonB);
      },
    );
    return result.when(
      handleFailure,
      (MovieModel movie) => Right<HttpRequestFailure, MovieModel>(movie),
    );
  }
}
