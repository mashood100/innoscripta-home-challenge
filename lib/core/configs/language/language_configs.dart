
class Language {
  final String code;
  final String countryCode;
  final String name;

  const Language({
    required this.code,
    required this.countryCode,
    required this.name,
  });
}

class LanguageConfig {
  static const List<Language> supportedLanguages = [
    Language(code: 'en', countryCode: 'US', name: 'English'),
    Language(code: 'de', countryCode: 'DE', name: 'Dutch'),
    Language(code: 'fr', countryCode: 'FR', name: 'Français'),
  ];
}
