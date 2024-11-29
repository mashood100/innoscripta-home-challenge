import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_list.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/shimmer/project_shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteProjectsScreen extends StatelessWidget {
  const FavoriteProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favoriteProjects),
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state.status == ProjectStatus.loading) {
            return const CustomScrollView(
              slivers: [ProjectShimmer()],
            );
          }

          if (state.status == ProjectStatus.error) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(child: Text(state.errorMessage)),
                ),
              ],
            );
          }

          final favoriteProjects =
              state.projects.where((p) => p.isFavorite).toList();

          return CustomScrollView(
            slivers: [
              if (favoriteProjects.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child:
                        Text(AppLocalizations.of(context)!.noFavoriteProjects),
                  ),
                )
              else
                ProjectList(projects: favoriteProjects),
            ],
          );
        },
      ),
    );
  }
}
