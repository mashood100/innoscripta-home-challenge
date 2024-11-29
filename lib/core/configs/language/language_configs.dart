import 'package:flutter/src/widgets/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  ];

  static List<LocalizationsDelegate> localizations = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static List<Locale> supportedLanguage = const [
    Locale('en'),
    Locale('de'),
  ];
}
