import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState.initial()) {
    on<LanguageChanged>(_onLanguageChanged);
  }

  void _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) {
    emit(state.copyWith(
      currentLanguage: event.code,
      currentCountryCode: event.countryCode,
    ));
  }
}