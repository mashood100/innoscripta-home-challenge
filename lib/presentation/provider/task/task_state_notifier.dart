import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/repository/task/tasks_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/task/tasks_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';
import 'dart:developer';

class TaskStateNotifier extends StateNotifier<TaskState> {
  TaskStateNotifier({
    required Ref ref,
  })  : _ref = ref,
        _taskUseCase = TasksUseCases(
          repository: TasksRepositoryImpl(api: TasksApiService()),
        ),
        super(TaskState.initial());

  final Ref _ref;
  final TasksUseCases _taskUseCase;

  Future<void> createTask(Task task) async {
    try {
      state = state.copyWith(status: TaskProviderState.loading);
      await _taskUseCase.create(task);
      final tasks = await _taskUseCase.getAll();
      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: tasks,
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getAllTasks() async {
    try {
      state = state.copyWith(status: TaskProviderState.loading);

      final tasks = await _taskUseCase.getAll();

      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: tasks,
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateTaskStatus(Task task, String newStatus) async {
    try {
      // Remove any existing status labels
      final currentLabels = task.labels!
          .where(
              (label) => !['todo', 'in_progress', 'completed'].contains(label))
          .toList();

      // Add the new status label
      final updatedLabels = [...currentLabels, newStatus];

      // Create updated task with new labels
      final updatedTask = task.copyWith(
        labels: updatedLabels,
      );

      // Update the task in state
      final updatedTasks = state.tasks.map((t) {
        return t.id == task.id ? updatedTask : t;
      }).toList();

      state = state.copyWith(
        tasks: updatedTasks,
      );

      // Persist changes
      await _taskUseCase.update(updatedTask);
      SnackbarHelper.snackbarWithTextOnly('Task status updated successfully');
    } catch (e) {
      SnackbarHelper.snackbarWithTextOnly('Failed to update task status');
      log('Update task status error: $e');
    }
  }
}
