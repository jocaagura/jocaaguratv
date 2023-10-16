import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import '../genre_model/genre_model.dart';
import '../media/media_model.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
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
  const MovieModel._();
  factory MovieModel.fromJson(Json json) => _$MovieModelFromJson(json);

  MediaModel toMedia() {
    return MediaModel(
      id: id,
      title: title,
      overview: overview,
      originalTitle: originalTitle,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      type: MediaType.movie,
    );
  }
}
