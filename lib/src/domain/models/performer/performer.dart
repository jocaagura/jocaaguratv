// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import '../media/media_model.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
class PerformerModel with _$PerformerModel {
  factory PerformerModel({
    required int id,
    required String name,
    required double popularity,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'profile_path') required String profilePath,
    @JsonKey(name: 'known_for', fromJson: knownForFromJson)
    required List<MediaModel> knownFor,
  }) = _Performer;
  factory PerformerModel.fromJson(Json json) => _$PerformerModelFromJson(json);
}

List<MediaModel> knownForFromJson(List<dynamic> list) {
  return list
      .where(
        (dynamic element) =>
            (element as Json)['media_type'] == 'person' &&
            element['poster_path'] != null &&
            element['backdrop_path'] != null,
      )
      .map((dynamic e) => MediaModel.fromJson(e as Json))
      .toList();
}
