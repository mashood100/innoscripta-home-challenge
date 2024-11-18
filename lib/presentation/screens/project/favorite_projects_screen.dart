import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteProjectsScreen extends ConsumerWidget {
  const FavoriteProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectStateProvider);
    final favoriteProjects =
        projectState.projects.where((p) => p.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favoriteProjects),
      ),
      body: CustomScrollView(
        slivers: [
          if (favoriteProjects.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(AppLocalizations.of(context)!.noFavoriteProjects),
              ),
            )
          else
            ProjectList(projects: favoriteProjects),
        ],
      ),
    );
  }
}
