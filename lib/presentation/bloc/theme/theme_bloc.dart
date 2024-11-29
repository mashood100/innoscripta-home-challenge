import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<InitializeThemeEvent>(_onInitializeTheme);
  }

  void _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void _onInitializeTheme(
    InitializeThemeEvent event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(isDarkMode: event.isDark));
  }
}
