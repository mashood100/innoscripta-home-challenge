import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_row.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/presentation_provider.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

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
      await taskStateNotifier.getAllTasks();
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
    // Filter tasks by labels
    final todoTasks =
        taskState.tasks.where((task) => task.labels!.contains('todo')).toList();
    final inProgressTasks = taskState.tasks
        .where((task) => task.labels!.contains('in_progress'))
        .toList();
    final completedTasks = taskState.tasks
        .where((task) => task.labels!.contains('completed'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Space.all(),
              child: Text('To Do', style: AppText.titleLarge),
            ),
            TaskRow(
              tasks: todoTasks,
              status: 'todo',
              onTaskMoved: _onTaskMoved,
            ),
            Space.y2,
            Padding(
              padding: Space.all(),
              child: Text('In Progress', style: AppText.titleLarge),
            ),
            TaskRow(
              tasks: inProgressTasks,
              status: 'in_progress',
              onTaskMoved: _onTaskMoved,
            ),
            Space.y2,
            Padding(
              padding: Space.all(),
              child: Text('Completed', style: AppText.titleLarge),
            ),
            TaskRow(
              tasks: completedTasks,
              status: 'completed',
              onTaskMoved: _onTaskMoved,
            ),
          ],
        ),
      ),
    );
  }
}
