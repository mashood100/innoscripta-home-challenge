import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/core/configs/language/language_configs.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_state.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_state.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_router.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';
import 'package:innoscripta_home_challenge/presentation/theme/core_theme.dart';

class HomeChallenge extends StatelessWidget {
  const HomeChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            return MaterialApp.router(
              routerConfig: goRouter,
              locale: Locale(
                languageState.currentLanguage,
                languageState.currentCountryCode,
              ),
              title: 'Innoscripta Task challenge',
              theme: themeLight,
              darkTheme: themeDark,
              scaffoldMessengerKey: SnackbarHelper.scaffoldMessengerKey,
              themeMode:
                  themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: LanguageConfig.localizations,
              supportedLocales: LanguageConfig.supportedLanguage,
            );
          },
        );
      },
    );
  }
}
