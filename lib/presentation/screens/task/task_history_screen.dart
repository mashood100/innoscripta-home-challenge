import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/closed_task_card.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskHistoryScreen extends ConsumerStatefulWidget {
  const TaskHistoryScreen({super.key});

  @override
  ConsumerState<TaskHistoryScreen> createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends ConsumerState<TaskHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadClosedTasks();
    });
  }

  Future<void> _loadClosedTasks() async {
    await ref.read(taskStateProvider.notifier).loadClosedTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskStateProvider);
    final closedTasks = taskState.closedTasks;
    final isLoading =
        taskState.completedTaskStatus == CompletedTaskState.loading;

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
  }
}
