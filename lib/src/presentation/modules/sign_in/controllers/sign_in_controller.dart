import 'package:flutter/foundation.dart';

import 'sign_in_state.dart';

class SignInController extends ChangeNotifier {
  SignInState _state = SignInState();

  SignInState get state => _state;

  bool get mount => _mount;
  bool _mount = true;
  void onUserNameChanged(String text) {
    _state = state.copyWith(
      username: text.trim().toLowerCase(),
    );
    notifyListeners();
  }

  void onUserPasswordChanged(String text) {
    _state = state.copyWith(
      password: text.replaceAll(' ', ''),
    );
    notifyListeners();
  }

  void onFetchingChanged(bool value) {
    _state = _state.copyWith(
      validating: value,
    );
    notifyListeners();
  }

  void validate() {}
  @override
  void dispose() {
    _mount = false;
    super.dispose();
  }
}
