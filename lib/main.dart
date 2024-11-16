import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_router.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';
import 'package:innoscripta_home_challenge/presentation/theme/core_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences localStorage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStorage = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'innoscripta Task challenge',
      theme: themeLight,
      darkTheme: themeDark,
      scaffoldMessengerKey: SnackbarHelper.scaffoldMessengerKey,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // home: const ProjectScreen(),
    );
  }
}
