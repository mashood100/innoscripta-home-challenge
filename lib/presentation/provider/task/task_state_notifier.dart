import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
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

      // After creating the task, get all tasks to ensure proper state
      final tasks = await _taskUseCase.getAll();

      // Update durations map
      final taskDurations = Map<String, int>.from(state.taskDurations);
      if (task.id != null) {
        taskDurations[task.id!] = task.duration?.amount ?? 0;
      }

      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: tasks,
        taskDurations: taskDurations,
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

      // Create a map of task durations
      final taskDurations = {
        for (var task in tasks) task.id!: task.duration?.amount ?? 0
      };

      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: tasks,
        taskDurations: taskDurations,
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
      final currentLabels = task.labels!
          .where(
              (label) => !['todo', 'in_progress', 'completed'].contains(label))
          .toList();

      final updatedLabels = [...currentLabels, newStatus];

      final updatedTask = task.copyWith(
        labels: updatedLabels,
      );

      final updatedTasks = state.tasks.map((t) {
        return t.id == task.id ? updatedTask : t;
      }).toList();

      state = state.copyWith(
        tasks: updatedTasks,
      );
      await _taskUseCase.update(updatedTask);
      SnackbarHelper.snackbarWithTextOnly('Task status updated successfully');
    } catch (e) {
      SnackbarHelper.snackbarWithTextOnly('Failed to update task status');
      log('Update task status error: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final taskIndex = state.tasks.indexWhere((t) => t.id == task.id);
      if (taskIndex == -1) return;

      // Update backend with seconds
      await _taskUseCase.update(task);

      // Update local state
      final updatedTasks = List<Task>.from(state.tasks);
      updatedTasks[taskIndex] = task;

      state = state.copyWith(
        tasks: updatedTasks,
        status: TaskProviderState.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateTaskDuration(String taskId, int seconds) async {
    try {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == taskId) {
          return task.copyWith(
            duration: TaskDuration(
              amount: (seconds / 60).ceil(), // Convert seconds to minutes
              unit: 'minute'
            )
          );
        }
        return task;
      }).toList();

      final updatedDurations = Map<String, int>.from(state.taskDurations)
        ..[taskId] = seconds; // Keep seconds in local state for timer

      // Update state first
      state = state.copyWith(
        tasks: updatedTasks,
        taskDurations: updatedDurations,
      );

      // Then update the backend
      final taskToUpdate = updatedTasks.firstWhere((task) => task.id == taskId);
      await _taskUseCase.update(taskToUpdate);

      SnackbarHelper.snackbarWithTextOnly('Task duration updated successfully');
    } catch (e) {
      log('Update task duration error: $e');
      SnackbarHelper.snackbarWithTextOnly('Failed to update task duration');
    }
  }
}
