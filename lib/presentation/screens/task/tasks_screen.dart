import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/task_header.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/task_row.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/shimmer/task_header_shimmer.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/shimmer/task_section_shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.project});
  final Project project;
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>()
        ..add(ClearTasksEvent())
        ..add(GetAllTasksEvent(widget.project.id!));
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    ScreenUtil.init(context, designSize: const Size(390, 848));

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final todoTasks = state.tasks
            .where((task) => task.labels!.contains('todo'))
            .toList();
        final inProgressTasks = state.tasks
            .where((task) => task.labels!.contains('in_progress'))
            .toList();
        final completedTasks = state.tasks
            .where((task) => task.labels!.contains('completed'))
            .toList();

        final isLoading = state.status == TaskStatus.loading;

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
                      totalTasks: state.tasks.length,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTaskSection(
                        AppLocalizations.of(context)!.noTodoTasks,
                        todoTasks,
                        'todo',
                        isLoading,
                      ),
                      Space.y2,
                      _buildTaskSection(
                        AppLocalizations.of(context)!.noInProgressTasks,
                        inProgressTasks,
                        'in_progress',
                        isLoading,
                      ),
                      Space.y2,
                      _buildTaskSection(
                        AppLocalizations.of(context)!.noCompletedTasks,
                        completedTasks,
                        'completed',
                        isLoading,
                      ),
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
      },
    );
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

  void _onTaskMoved(Task task, String newStatus) {
    context.read<TaskBloc>().add(UpdateTaskStatusEvent(task, newStatus));
  }
}
