import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/data/repository/task/tasks_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/task/tasks_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';
import 'dart:developer';
import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';

class TaskStateNotifier extends StateNotifier<TaskState> {
  TaskStateNotifier({
    required TaskStorageUseCases taskStorageUseCases,
  })  : _taskUseCase = TasksUseCases(
          repository: TasksRepositoryImpl(api: TasksApiService()),
        ),
        _taskStorageUseCases = taskStorageUseCases,
        super(TaskState.initial());

  final TasksUseCases _taskUseCase;
  final TaskStorageUseCases _taskStorageUseCases;

//============================== Create Task ==============================
  /// Creates a new task and adds it to the tasks list with duration tracking
  Future<void> createTask(
    Task newtask,
  ) async {
    final initialState = state;

    try {
      state = state.copyWith(status: TaskProviderState.loading);
      final createdTask = await _taskUseCase.create(newtask);

      final updatedTasks = [...state.tasks, createdTask];

      final taskDurations = Map<String, int>.from(state.taskDurations);
      if (createdTask.id != null) {
        taskDurations[createdTask.id!] = createdTask.duration?.amount ?? 0;
      }

      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: updatedTasks,
        taskDurations: taskDurations,
      );
    } catch (e) {
      state = initialState.copyWith(
        status: TaskProviderState.initial,
        errorMessage: e.toString(),
      );
    }
  }

//============================== Get All Task ==============================
  /// Fetches all tasks for a specific project and initializes their durations
  Future<void> getAllTasks(String projectId) async {
    try {
      state = state.copyWith(status: TaskProviderState.loading);
      final tasks = await _taskUseCase.getAll(projectId);

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
        status: TaskProviderState.initial,
        errorMessage: e.toString(),
      );
    }
  }

//============================== Update Status==============================
  /// Updates the task's status label (todo, in_progress, completed)
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

//============================== Update Task ==============================
  /// Updates an existing task's details in the task list
  Future<void> updateTask(Task task) async {
    try {
      final taskIndex = state.tasks.indexWhere((t) => t.id == task.id);
      if (taskIndex == -1) return;
      await _taskUseCase.update(task);
      final updatedTasks = List<Task>.from(state.tasks);
      updatedTasks[taskIndex] = task;

      state = state.copyWith(
        tasks: updatedTasks,
        status: TaskProviderState.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskProviderState.initial,
        errorMessage: e.toString(),
      );
    }
  }

//============================== Update Duration ==============================
  /// Updates the time duration spent on a specific task
  Future<void> updateTaskDuration(String taskId, int seconds) async {
    try {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == taskId) {
          return task.copyWith(
              duration:
                  TaskDuration(amount: (seconds / 60).ceil(), unit: 'minute'));
        }
        return task;
      }).toList();

      final updatedDurations = Map<String, int>.from(state.taskDurations)
        ..[taskId] = seconds;

      state = state.copyWith(
        tasks: updatedTasks,
        taskDurations: updatedDurations,
      );

      final taskToUpdate = updatedTasks.firstWhere((task) => task.id == taskId);
      await _taskUseCase.update(taskToUpdate);

      // SnackbarHelper.snackbarWithTextOnly('Task duration updated successfully');
    } catch (e) {
      log('Update task duration error: $e');
      SnackbarHelper.snackbarWithTextOnly('Failed to update task duration');
    }
  }

//============================== Clear Task ==============================
  /// Clears all tasks from the state
  void clearTasks() {
    state = state.copyWith(tasks: []);
  }

//============================== Delete Task ==============================
  /// Removes a task from the list and updates the duration tracking
  Future<void> deleteTask(Task task) async {
    final initialState = state;

    try {
      await _taskUseCase.delete(task);
      final updatedTasks = state.tasks.where((t) => t.id != task.id).toList();
      final updatedDurations = Map<String, int>.from(state.taskDurations)
        ..remove(task.id);

      state = state.copyWith(
        status: TaskProviderState.success,
        tasks: updatedTasks,
        taskDurations: updatedDurations,
      );

      SnackbarHelper.snackbarWithTextOnly('Task deleted successfully');
    } catch (e) {
      state = initialState.copyWith(
        status: TaskProviderState.initial,
        errorMessage: e.toString(),
      );
      SnackbarHelper.snackbarWithTextOnly('Failed to delete task');
      log('Delete task error: $e');
    }
  }

//============================== Load Closed Tasks ==============================
  /// Loads previously closed tasks from local storage
  Future<void> loadClosedTasks() async {
    try {
      state = state.copyWith(completedTaskStatus: CompletedTaskState.loading);
      final closedTasks = await _taskStorageUseCases.getClosedTasks();

      state = state.copyWith(
        closedTasks: closedTasks,
        completedTaskStatus: CompletedTaskState.success,
      );
    } catch (e) {
      state = state.copyWith(
        completedTaskStatus: CompletedTaskState.initial,
        errorMessage: e.toString(),
      );
    }
  }

//============================== Close Task ==============================
  /// Marks a task as closed and moves it to the closed tasks list
  Future<void> closeTask(Task task) async {
    try {
      final updatedTask = task.copyWith(
        labels: [...task.labels ?? [], 'closed'],
      );

      await _taskUseCase.close(updatedTask);

      final updatedTasks = state.tasks.where((t) => t.id != task.id).toList();
      final updatedClosedTasks = [...state.closedTasks, updatedTask];

      await _taskStorageUseCases.saveClosedTasks(updatedClosedTasks);

      state = state.copyWith(
        tasks: updatedTasks,
        closedTasks: updatedClosedTasks,
        completedTaskStatus: CompletedTaskState.success,
      );

      SnackbarHelper.snackbarWithTextOnly('Task closed successfully');
    } catch (e) {
      state = state.copyWith(
        completedTaskStatus: CompletedTaskState.initial,
        errorMessage: e.toString(),
      );
      SnackbarHelper.snackbarWithTextOnly('Failed to close task');
      log('Close task error: $e');
    }
  }
}
