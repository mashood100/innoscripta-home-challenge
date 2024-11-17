import 'dart:math' show max;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/core/utils/colors_utils.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_row.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:go_router/go_router.dart';

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
    final totalTasks = taskState.tasks.length;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.name ?? 'Project',
                                style: AppText.titleLargeSemiBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '$totalTasks tasks',
                                style: AppText.bodySmall.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.r, left: 10.r),
                            child: CircleAvatar(
                              radius: 10.r,
                              backgroundColor: ColorUtility.getColorFromString(
                                  widget.project.color!),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: Space.all(),
                    child: Text('To Do', style: AppText.titleLarge),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: max(MediaQuery.of(context).size.width,
                          todoTasks.length * 300.0),
                      child: TaskRow(
                        tasks: todoTasks,
                        status: 'todo',
                        onTaskMoved: _onTaskMoved,
                      ),
                    ),
                  ),
                  Space.y2,
                  Padding(
                    padding: Space.all(),
                    child: Text('In Progress', style: AppText.titleLarge),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: max(MediaQuery.of(context).size.width,
                          inProgressTasks.length * 300.0),
                      child: TaskRow(
                        tasks: inProgressTasks,
                        status: 'in_progress',
                        onTaskMoved: _onTaskMoved,
                      ),
                    ),
                  ),
                  Space.y2,
                  Padding(
                    padding: Space.all(),
                    child: Text('Completed', style: AppText.titleLarge),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: max(MediaQuery.of(context).size.width,
                          completedTasks.length * 300.0),
                      child: TaskRow(
                        tasks: completedTasks,
                        status: 'completed',
                        onTaskMoved: _onTaskMoved,
                      ),
                    ),
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
  }
}
