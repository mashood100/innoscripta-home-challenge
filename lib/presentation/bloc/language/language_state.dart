class LanguageState {
  final String currentLanguage;
  final String currentCountryCode;

  LanguageState({
    required this.currentLanguage,
    required this.currentCountryCode,
  });

  factory LanguageState.initial() {
    return LanguageState(
      currentLanguage: 'en',
      currentCountryCode: 'US',
    );
  }

  LanguageState copyWith({
    String? currentLanguage,
    String? currentCountryCode,
  }) {
    return LanguageState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentCountryCode: currentCountryCode ?? this.currentCountryCode,
    );
  }
}