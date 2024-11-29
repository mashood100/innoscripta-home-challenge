import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/add_project_button.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/drawer/home_screen_drawer.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_list.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/shimmer/project_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/empty_project_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/theme/theme_state.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    context.read<ProjectBloc>().add(GetAllProjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    ScreenUtil.init(context, designSize: const Size(390, 848));

    return Scaffold(
      drawer: const HomeScreenDrawer(),
      body: RefreshIndicator(
        onRefresh: _loadProjects,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(AppLocalizations.of(context)!.projectTitle),
              actions: [
                IconButton(
                  icon: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Icon(
                        state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      );
                    },
                  ),
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                ),
              ],
            ),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state.status == ProjectStatus.loading) {
                  return const ProjectShimmer();
                } else if (state.status == ProjectStatus.error) {
                  return SliverFillRemaining(
                    child: Center(child: Text(state.errorMessage)),
                  );
                } else if (state.projects.isEmpty &&
                    state.status == ProjectStatus.success) {
                  return const EmptyProjectState();
                } else {
                  return ProjectList(projects: state.projects);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const AddProjectButton(),
    );
  }
}
