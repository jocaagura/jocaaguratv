import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import '../genre_model/genre_model.dart';
import '../media/media_model.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  factory MovieModel({
    required int id,
    required List<GenreModel> genres,
    required int runtime,
    required String overview,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'release_date') required DateTime realeaseDate,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(readValue: readOriginalTitleValue) required String originalTitle,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
  }) = _MovieModel;
  factory MovieModel.fromJson(Json json) => _$MovieModelFromJson(json);
}
