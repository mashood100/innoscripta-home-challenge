import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEditing;

  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        isEditing
            ? AppLocalizations.of(context)!.updateProject
            : AppLocalizations.of(context)!.createNewProject,
      ),
    );
  }
}
