class Language {
  final String name;
  final String code;
  final String countryCode;

  const Language({
    required this.name,
    required this.code,
    required this.countryCode,
  });
}

class LanguageConfig {
  static const List<Language> supportedLanguages = [
    Language(
      name: 'English',
      code: 'en',
      countryCode: 'US',
    ),
    Language(
      name: 'Deutsch',
      code: 'de',
      countryCode: 'DE',
    ),
  ];
}
