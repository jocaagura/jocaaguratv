import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int id;
  final String username;

  @override
  int get hashCode => '$id$username'.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        other is UserModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            username == other.username;
  }

  UserModel copyWith({
    String? username,
    int? id,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
