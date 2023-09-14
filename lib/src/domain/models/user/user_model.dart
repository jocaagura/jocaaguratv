// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@immutable
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,

    ///
    @JsonKey(name: 'avatar', fromJson: avatarPathFromJson) String? avatarPath,
  }) = _UserModel;
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  if (json['tmdb'] != null && json['tmdb'] is Map) {
    final Map<String, dynamic> first = json['tmdb'] as Map<String, dynamic>;
    return first['avatar_path'] as String?;
  }
  return null;
}
