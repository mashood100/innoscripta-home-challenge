import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/bottom_sheet/add_project_bottom_sheet.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/screens/project/widgets/project_list.dart';

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

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Languages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadProjects,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Projects'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.face),
                  onPressed: () {},
                ),
              ],
            ),
            if (projectState.status == ProjectProviderState.loading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (projectState.status == ProjectProviderState.error)
              SliverFillRemaining(
                child: Center(child: Text(projectState.errorMessage)),
              )
            else
              ProjectList(projects: projectState.projects),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddProjectBottomSheet(),
          );
        },
        tooltip: 'Create New Project',
        child: const Icon(Icons.add),
      ),
    );
  }
}
