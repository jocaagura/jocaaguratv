// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

enum MediaType {
  @JsonValue('movie')
  movie,
  @JsonValue('tv')
  tv,
}

@freezed
class MediaModel with _$MediaModel {
  factory MediaModel({
    required int id,
    @JsonKey(
      readValue: readTitleValue,
    )
    required String title,
    required String overview,
    @JsonKey(name: 'original_title', readValue: readOriginalTitleValue)
    required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required MediaType type,
  }) = _MediaModel;
  factory MediaModel.fromJson(Json json) => _$MediaModelFromJson(json);
}

Object? readTitleValue(Map<dynamic, dynamic> map, String _) {
  return map['title'] ?? map['name'] ?? '';
}

Object? readOriginalTitleValue(Map<dynamic, dynamic> map, String _) {
  return map['original_title'] ?? map['original_name'] ?? '';
}
