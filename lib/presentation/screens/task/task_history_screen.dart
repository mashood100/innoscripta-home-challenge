import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/closed_task_card.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskHistoryScreen extends StatefulWidget {
  const TaskHistoryScreen({super.key});

  @override
  State<TaskHistoryScreen> createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends State<TaskHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadClosedTasks();
    });
  }

  Future<void> _loadClosedTasks() async {
    context.read<TaskBloc>().add(LoadClosedTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        final closedTasks = taskState.closedTasks;
        final isLoading = taskState.completedTaskStatus == CompletedTaskStatus.loading;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Task History"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: _loadClosedTasks,
                  child: closedTasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 64,
                                color: Theme.of(context).hintColor,
                              ),
                              Space.y2,
                              Text(
                                "No Closed Tasks",
                                style: AppText.titleMedium.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: Space.v,
                          itemCount: closedTasks.length,
                          itemBuilder: (context, index) {
                            return ClosedTaskCard(task: closedTasks[index]);
                          },
                        ),
                ),
        );
      },
    );
  }
}
