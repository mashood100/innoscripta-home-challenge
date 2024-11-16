import 'dart:math' show max;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/create_task_screen.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_row.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/theme/app.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key, required this.projectID});
  final String projectID;
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
      await taskStateNotifier.getAllTasks(widget.projectID);
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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await showMaterialModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CreateTaskScreen(
            projectId: widget.projectID,
          ),
        );
      }),
    );
  }
}
