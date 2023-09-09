import 'package:flutter/foundation.dart';

@immutable
class SignInState {
  const SignInState({
    this.username = '',
    this.password = '',
    this.validating = false,
  });

  final String username;
  final String password;
  final bool validating;

  SignInState copyWith({
    String? username,
    String? password,
    bool? validating,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      validating: validating ?? this.validating,
    );
  }

  @override
  int get hashCode => '$username$password$validating'.hashCode;

  @override
  bool operator ==(Object other) {
    return (identical(this, other)) ||
        other is SignInState &&
            username == other.username &&
            password == other.password &&
            validating == other.validating;
  }
}
