import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
  });

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
}
