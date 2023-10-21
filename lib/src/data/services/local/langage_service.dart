class LanguageService {
  LanguageService(this._languageCode);

  String _languageCode;

  String get languageCode => _languageCode;

  set languageCode(String code) {
    _languageCode = code;
  }
}
