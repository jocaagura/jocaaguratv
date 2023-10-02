import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

@freezed
class GenreModel with _$GenreModel {
  factory GenreModel({
    required int id,
    required String name,
  }) = _GenreModel;
  factory GenreModel.fromJson(Json json) => _$GenreModelFromJson(json);
}
