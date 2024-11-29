import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/core/configs/language/language_configs.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_state.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/language/language_event.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: LanguageConfig.supportedLanguages.length,
            itemBuilder: (context, index) {
              final language = LanguageConfig.supportedLanguages[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(language.countryCode),
                ),
                title: Text(language.name),
                trailing: state.currentLanguage == language.code
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(LanguageChanged(
                    code: language.code,
                    countryCode: language.countryCode,
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
