import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';
import './task_event.dart';
import './task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TasksUseCases _taskUseCase;
  final TaskStorageUseCases _taskStorageUseCases;

  TaskBloc({
    required TasksUseCases taskUseCase,
    required TaskStorageUseCases taskStorageUseCases,
  })  : _taskUseCase = taskUseCase,
        _taskStorageUseCases = taskStorageUseCases,
        super(TaskState.initial()) {
    on<CreateTaskEvent>(_onCreateTask);
    on<GetAllTasksEvent>(_onGetAllTasks);
    on<UpdateTaskStatusEvent>(_onUpdateTaskStatus);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<UpdateTaskDurationEvent>(_onUpdateTaskDuration);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<LoadClosedTasksEvent>(_onLoadClosedTasks);
    on<CloseTaskEvent>(_onCloseTask);
    on<ClearTasksEvent>(_onClearTasks);
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final initialState = state;
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      final createdTask = await _taskUseCase.create(event.task);

      final updatedTasks = [...state.tasks, createdTask];
      final taskDurations = Map<String, int>.from(state.taskDurations);
      if (createdTask.id != null) {
        taskDurations[createdTask.id!] = createdTask.duration?.amount ?? 0;
      }

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: updatedTasks,
        taskDurations: taskDurations,
      ));
    } catch (e) {
      emit(initialState.copyWith(
        status: TaskStatus.initial,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetAllTasks(
    GetAllTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TaskStatus.loading));
      final tasks = await _taskUseCase.getAll(event.projectId);

      final taskDurations = {
        for (var task in tasks) task.id!: task.duration?.amount ?? 0
      };

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: tasks,
        taskDurations: taskDurations,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.initial,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatusEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final currentLabels = event.task.labels!
          .where((label) => !['todo', 'in_progress', 'completed'].contains(label))
          .toList();

      final updatedLabels = [...currentLabels, event.newStatus];
      final updatedTask = event.task.copyWith(labels: updatedLabels);

      final updatedTasks = state.tasks.map((t) {
        return t.id == event.task.id ? updatedTask : t;
      }).toList();

      emit(state.copyWith(tasks: updatedTasks));
      await _taskUseCase.update(updatedTask);
      SnackbarHelper.snackbarWithTextOnly('Task status updated successfully');
    } catch (e) {
      SnackbarHelper.snackbarWithTextOnly('Failed to update task status');
      log('Update task status error: $e');
    }
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final taskIndex = state.tasks.indexWhere((t) => t.id == event.task.id);
      if (taskIndex == -1) return;
      
      await _taskUseCase.update(event.task);
      final updatedTasks = List<Task>.from(state.tasks);
      updatedTasks[taskIndex] = event.task;

      emit(state.copyWith(
        tasks: updatedTasks,
        status: TaskStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskStatus.initial,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateTaskDuration(
    UpdateTaskDurationEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == event.taskId) {
          return task.copyWith(
            duration: TaskDuration(
              amount: (event.seconds / 60).ceil(),
              unit: 'minute',
            ),
          );
        }
        return task;
      }).toList();

      final updatedDurations = Map<String, int>.from(state.taskDurations)
        ..[event.taskId] = event.seconds;

      emit(state.copyWith(
        tasks: updatedTasks,
        taskDurations: updatedDurations,
      ));

      final taskToUpdate = updatedTasks.firstWhere((task) => task.id == event.taskId);
      await _taskUseCase.update(taskToUpdate);
    } catch (e) {
      log('Update task duration error: $e');
      SnackbarHelper.snackbarWithTextOnly('Failed to update task duration');
    }
  }

  void _onClearTasks(
    ClearTasksEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(tasks: []));
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final initialState = state;
    try {
      await _taskUseCase.delete(event.task);
      final updatedTasks = state.tasks.where((t) => t.id != event.task.id).toList();
      final updatedDurations = Map<String, int>.from(state.taskDurations)
        ..remove(event.task.id);

      emit(state.copyWith(
        status: TaskStatus.success,
        tasks: updatedTasks,
        taskDurations: updatedDurations,
      ));

      SnackbarHelper.snackbarWithTextOnly('Task deleted successfully');
    } catch (e) {
      emit(initialState.copyWith(
        status: TaskStatus.initial,
        errorMessage: e.toString(),
      ));
      SnackbarHelper.snackbarWithTextOnly('Failed to delete task');
      log('Delete task error: $e');
    }
  }

  Future<void> _onLoadClosedTasks(
    LoadClosedTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(completedTaskStatus: CompletedTaskStatus.loading));
      final closedTasks = await _taskStorageUseCases.getClosedTasks();

      emit(state.copyWith(
        closedTasks: closedTasks,
        completedTaskStatus: CompletedTaskStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        completedTaskStatus: CompletedTaskStatus.initial,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCloseTask(
    CloseTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final updatedTask = event.task.copyWith(
        labels: [...event.task.labels ?? [], 'closed'],
      );

      await _taskUseCase.close(updatedTask);

      final updatedTasks = state.tasks.where((t) => t.id != event.task.id).toList();
      final updatedClosedTasks = [...state.closedTasks, updatedTask];

      await _taskStorageUseCases.saveClosedTasks(updatedClosedTasks);

      emit(state.copyWith(
        tasks: updatedTasks,
        closedTasks: updatedClosedTasks,
        completedTaskStatus: CompletedTaskStatus.success,
      ));

      SnackbarHelper.snackbarWithTextOnly('Task closed successfully');
    } catch (e) {
      emit(state.copyWith(
        completedTaskStatus: CompletedTaskStatus.initial,
        errorMessage: e.toString(),
      ));
      SnackbarHelper.snackbarWithTextOnly('Failed to close task');
      log('Close task error: $e');
    }
  }
}