import 'package:flutter/foundation.dart';

import '../../../domain/repositories/preference_repository.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(
    this._isDarkMode,
    this._preferenceRepository,
  );
  final PreferenceRepository _preferenceRepository;
  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  void onChanged(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _preferenceRepository.darkMode = isDarkMode;
    notifyListeners();
  }

  void toggleTheme() {
    onChanged(!_isDarkMode);
  }
}
