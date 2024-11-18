import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/add_project_button.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/drawer/home_screen_drawer.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_list.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/shimmer/project_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/empty_project_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final projectStateNotifier = ref.read(projectStateProvider.notifier);
      await projectStateNotifier.getAllProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    ScreenUtil.init(context, designSize: const Size(390, 848));
    final projectState = ref.watch(projectStateProvider);
    final isDarkMode = ref.watch(themeProvider);

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
                    icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ],
              ),
              if (projectState.status == ProjectProviderState.loading)
                const ProjectShimmer()
              else if (projectState.status == ProjectProviderState.error)
                SliverFillRemaining(
                  child: Center(child: Text(projectState.errorMessage)),
                )
              else if (projectState.projects.isEmpty &&
                  projectState.status == ProjectProviderState.success)
                const EmptyProjectState()
              else
                ProjectList(projects: projectState.projects),
            ],
          ),
        ),
        floatingActionButton: const AddProjectButton());
  }
}
