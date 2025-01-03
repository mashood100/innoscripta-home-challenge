import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_item.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectPreview extends StatelessWidget {
  final Project project;

  const ProjectPreview({
    super.key,
    required this.project,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.projectPreviewLabel,
            style: AppText.bodyMedium),
        Space.y1,
        ProjectItem(
          project: project,
          isPreview: true,
        ),
      ],
    );
  }
}
