class SignInState {
  SignInState({
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
}
