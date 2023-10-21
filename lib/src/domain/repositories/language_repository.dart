import '../../data/services/local/langage_service.dart';

abstract class LanguageRepository {
  const LanguageRepository(this.languageService);

  final LanguageService languageService;

  void setLanguageCode(String code);
}
