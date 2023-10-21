import '../../../domain/repositories/language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  const LanguageRepositoryImpl(super.languageService);

  @override
  void setLanguageCode(String code) {
    languageService.languageCode = code;
  }
}
