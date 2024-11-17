import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_item.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class ProjectPreview extends ConsumerWidget {
  final Project project;

  const ProjectPreview({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('How it will look:', style: AppText.bodyMedium),
        Space.y1,
        ProjectItem(project: project),
      ],
    );
  }
}
