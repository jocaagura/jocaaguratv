import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _userName = '';
  String _password = '';

  bool _validating = false;

  String get username => _userName;
  String get password => _password;
  bool get validating => _validating;
  bool get mount => _mount;
  bool _mount = true;
  void onUserNameChanged(String text) {
    _userName = text.trim().toLowerCase();
    notifyListeners();
  }

  void onUserPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
    notifyListeners();
  }

  void onFetchingChanged(bool value) {
    _validating = value;
    notifyListeners();
  }

  void validate() {}
  @override
  void dispose() {
    _mount = false;
    super.dispose();
  }
}
