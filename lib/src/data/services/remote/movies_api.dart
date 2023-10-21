import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/movie/movie_model.dart';
import '../../../domain/models/performer/performer.dart';
import '../../../domain/typedefs.dart';
import '../http/http.dart';
import '../local/langage_service.dart';
import '../utils/handle_failure.dart';

class MoviesApi {
  const MoviesApi(this._http, this._languageService);
  final Http _http;
  final LanguageService _languageService;

  Future<Either<HttpRequestFailure, MovieModel>> getMovieById(
    int id,
  ) async {
    final Either<HttpFailure, MovieModel> result = await _http.request(
      '3/movie/$id',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'language': _languageService.languageCode,
      },
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

  Future<Either<HttpRequestFailure, List<PerformerModel>>> getCastByMovieId(
    int movieId,
  ) async {
    final Either<HttpFailure, List<PerformerModel>> result =
        await _http.request(
      '3/movie/$movieId/credits',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'language': _languageService.languageCode,
      },
      onSuccess: (String json) {
        final Json jsonB = jsonDecode(json) as Json;
        final List<Json> list =
            List<Json>.from(jsonB['cast'] as Iterable<dynamic>);

        final List<PerformerModel> performersList = <PerformerModel>[];
        for (final Json element in list) {
          if (element['known_for_department'] == 'Acting') {
            performersList.add(
              PerformerModel.fromJson(
                <String, dynamic>{...element, 'known_for': <Json>[]},
              ),
            );
          }
        }
        return performersList;
      },
    );
    return result.when(
      handleFailure,
      (List<PerformerModel> value) =>
          Right<HttpRequestFailure, List<PerformerModel>>(value),
    );
  }
}
