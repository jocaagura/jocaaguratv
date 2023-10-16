import 'package:flutter/foundation.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(
    this._isDarkMode,
  );
  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  void onChanged(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  void toggleTheme() {
    onChanged(!_isDarkMode);
  }
}
