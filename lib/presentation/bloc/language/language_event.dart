abstract class LanguageEvent {}

class LanguageChanged extends LanguageEvent {
  final String code;
  final String countryCode;

  LanguageChanged({required this.code, required this.countryCode});
}