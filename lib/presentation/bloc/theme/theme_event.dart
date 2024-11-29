abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class InitializeThemeEvent extends ThemeEvent {
  final bool isDark;
  InitializeThemeEvent(this.isDark);
}