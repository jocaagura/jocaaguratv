import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

@freezed
class MediaModel with _$MediaModel {
  factory MediaModel({
    required int id,
    required String title,
    required String overview,
    @JsonKey(name: 'original_tittle') required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required double type,
  }) = _MediaModel;
  factory MediaModel.fromJson(Json json) => _$MediaModelFromJson(json);
}
