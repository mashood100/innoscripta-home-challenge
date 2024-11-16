import 'package:flutter_riverpod/flutter_riverpod.dart';


class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // false means light theme, true means dark theme

  void toggleTheme() {
    state = !state;
  }
}
