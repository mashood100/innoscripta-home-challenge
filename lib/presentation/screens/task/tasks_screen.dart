import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/task_header.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/task_row.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/shimmer/task_header_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/shimmer/task_section_shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key, required this.project});
  final Project project;
  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final taskStateNotifier = ref.read(taskStateProvider.notifier);
      taskStateNotifier.clearTasks();
      await taskStateNotifier.getAllTasks(widget.project.id!);
    });
  }

  void _onTaskMoved(Task task, String newStatus) {
    ref.read(taskStateProvider.notifier).updateTaskStatus(task, newStatus);
  }

  Widget _buildTaskSection(
      String title, List<Task> tasks, String status, bool isLoading) {
    if (isLoading) {
      return const TaskSectionShimmer();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Space.all(15),
          child: Text(
            '$title (${tasks.length})',
            style: AppText.titleLarge,
          ),
        ),
        TaskRow(
          tasks: tasks,
          status: status,
          onTaskMoved: _onTaskMoved,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskStateProvider);
    App.init(context);
    ScreenUtil.init(context, designSize: const Size(390, 848));

    final todoTasks =
        taskState.tasks.where((task) => task.labels!.contains('todo')).toList();
    final inProgressTasks = taskState.tasks
        .where((task) => task.labels!.contains('in_progress'))
        .toList();
    final completedTasks = taskState.tasks
        .where((task) => task.labels!.contains('completed'))
        .toList();

    final isLoading = taskState.status == TaskProviderState.loading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoading)
                const TaskHeaderShimmer()
              else
                TaskHeader(
                  project: widget.project,
                  totalTasks: taskState.tasks.length,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskSection(AppLocalizations.of(context)!.noTodoTasks, todoTasks, 'todo', isLoading),
                  Space.y2,
                  _buildTaskSection(AppLocalizations.of(context)!.noInProgressTasks, inProgressTasks, 'in_progress', isLoading),
                  Space.y2,
                  _buildTaskSection(AppLocalizations.of(context)!.noCompletedTasks, completedTasks, 'completed', isLoading),
                  Space.yf(150),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            AppRoute.createTask.name,
            pathParameters: {'projectId': widget.project.id!},
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
