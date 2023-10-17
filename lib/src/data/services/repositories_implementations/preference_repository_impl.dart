import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/preference_repository.dart';

const String _keyDarkMode = 'isdarkmode';

class PreferenceRepositoryImpl extends PreferenceRepository {
  const PreferenceRepositoryImpl(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  @override
  bool get darkMode => _sharedPreferences.getBool(_keyDarkMode) ?? false;

  @override
  set darkMode(bool value) {
    _sharedPreferences.setBool(_keyDarkMode, value);
  }
}
