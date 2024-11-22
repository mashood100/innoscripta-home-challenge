import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/core/configs/language/language_configs.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';

final languageProvider = StateProvider<String>((ref) => 'en');

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: ListView.builder(
        itemCount: LanguageConfig.supportedLanguages.length,
        itemBuilder: (context, index) {
          final language = LanguageConfig.supportedLanguages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(language.countryCode),
            ),
            title: Text(language.name),
            trailing: currentLanguage == language.code
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              ref.read(languageProvider.notifier).state = language.code;
              final newLocale = Locale(language.code, language.countryCode);
              ref.read(localeProvider.notifier).state = newLocale;
            },
          );
        },
      ),
    );
  }
}
