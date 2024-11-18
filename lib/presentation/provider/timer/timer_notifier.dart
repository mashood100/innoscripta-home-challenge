import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/main.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/provider/timer/timer_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/providers/provider_instances.dart';

class TimerNotifier extends StateNotifier<TimerState> {
  final Map<String, Timer> _timers = {};
  final Ref _ref;

  TimerNotifier({
    required Ref ref,
  })  : _ref = ref,
        super(const TimerState()) {
    _restoreState();
  }

//============================== Task Duration Management ==============================
  /// Updates the duration of a task in minutes based on elapsed seconds
  Future<void> updateTaskDuration(String taskId, int seconds) async {
    try {
      final taskNotifier = _ref.read(taskStateProvider.notifier);
      final task = taskNotifier.state.tasks.firstWhere((t) => t.id == taskId);
      final updatedTask = task.copyWith(
          duration: TaskDuration(
              amount: (seconds / 60).ceil(), // Convert seconds to minutes
              unit: 'minute'));
      await taskNotifier.updateTask(updatedTask);
    } catch (e) {
      // Handle error
    }
  }

//============================== Timer Controls ==============================
  /// Starts or resumes a timer for a specific task
  void startTimer(Task task) {
    final taskId = task.id!;
    final existingTimer = state.taskTimers[taskId];

    if (existingTimer != null && existingTimer.isPaused) {
      // Resume timer
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = existingTimer.copyWith(isPaused: false);
      state = state.copyWith(taskTimers: updatedTimers);
    } else {
      // Start new timer
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = TaskTimer(
        currentDuration: task.duration?.amount ?? 0,
        startTime: DateTime.now(),
      );
      state = state.copyWith(taskTimers: updatedTimers);
    }

    _timers[taskId]?.cancel();
    _timers[taskId] = Timer.periodic(const Duration(seconds: 1), (_) {
      final currentTimer = state.taskTimers[taskId]!;
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = currentTimer.copyWith(
        currentDuration: currentTimer.currentDuration + 1,
      );
      state = state.copyWith(taskTimers: updatedTimers);
      _saveState();
    });
  }

  /// Pauses the timer for a specific task and saves its state
  void pauseTimer(String taskId) {
    _timers[taskId]?.cancel();
    _timers.remove(taskId);

    final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
    final timer = updatedTimers[taskId];
    if (timer != null) {
      updatedTimers[taskId] = timer.copyWith(isPaused: true);
      state = state.copyWith(taskTimers: updatedTimers);
      _saveState();
      updateTaskDuration(taskId, timer.currentDuration);
    }
  }

  /// Resets the timer and clears stored data for a specific task
  void resetTimer(String taskId) {
    _timers[taskId]?.cancel();
    _timers.remove(taskId);

    final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
    updatedTimers.remove(taskId);
    state = state.copyWith(taskTimers: updatedTimers);

    localStorage.remove('task_duration_$taskId');
    localStorage.remove('timer_${taskId}_is_paused');
    localStorage.remove('timer_${taskId}_start_time');

    updateTaskDuration(taskId, 0);
  }

//============================== Timer State Queries ==============================
  /// Checks if a timer is currently running for a specific task
  bool isTimerRunning(String taskId) {
    final timer = state.taskTimers[taskId];
    return timer != null && !timer.isPaused;
  }

  /// Checks if a timer is paused for a specific task
  bool isTimerPaused(String taskId) {
    final timer = state.taskTimers[taskId];
    return timer?.isPaused ?? false;
  }

  /// Gets the current duration in seconds for a specific task
  int getCurrentDuration(String taskId) {
    return state.taskTimers[taskId]?.currentDuration ?? 0;
  }

  /// Formats seconds into HH:MM:SS string format
  String getFormattedDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

//============================== State Persistence ==============================
  /// Saves the current state of all timers to local storage
  Future<void> _saveState() async {
    for (final entry in state.taskTimers.entries) {
      final taskId = entry.key;
      final timer = entry.value;

      // Save duration
      await localStorage.setInt('task_duration_$taskId', timer.currentDuration);

      // Save pause state
      await localStorage.setBool('timer_${taskId}_is_paused', timer.isPaused);

      // Save start time only if timer is running
      if (!timer.isPaused && timer.startTime != null) {
        await localStorage.setString(
          'timer_${taskId}_start_time',
          timer.startTime!.toIso8601String(),
        );
      } else {
        await localStorage.remove('timer_${taskId}_start_time');
      }
    }
  }

  /// Restores timer states from local storage on initialization
  Future<void> _restoreState() async {
    final tasks = _ref.read(taskStateProvider).tasks;
    final updatedTimers = <String, TaskTimer>{};

    for (final task in tasks) {
      if (task.id != null) {
        // Get the stored duration
        final duration = await getTaskDuration(task.id!);
        final startTimeStr =
            localStorage.getString('timer_${task.id!}_start_time');
        final isPaused =
            localStorage.getBool('timer_${task.id!}_is_paused') ?? true;

        if (startTimeStr != null && startTimeStr.isNotEmpty && !isPaused) {
          final startTime = DateTime.parse(startTimeStr);
          updatedTimers[task.id!] = TaskTimer(
            currentDuration: duration,
            startTime: startTime,
            isPaused: false,
          );

          _startPeriodicTimer(task.id!);
        } else {
          updatedTimers[task.id!] = TaskTimer(
            currentDuration: duration,
            isPaused: true,
          );
        }
      }
    }

    state = TimerState(taskTimers: updatedTimers);
  }

  /// Creates and starts a periodic timer for a specific task
  void _startPeriodicTimer(String taskId) {
    _timers[taskId] = Timer.periodic(const Duration(seconds: 1), (_) {
      final currentTimer = state.taskTimers[taskId]!;
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = currentTimer.copyWith(
        currentDuration: currentTimer.currentDuration + 1,
      );
      state = state.copyWith(taskTimers: updatedTimers);
      _saveState();
    });
  }

  /// Retrieves stored duration for a specific task
  Future<int> getTaskDuration(String taskId) async {
    return localStorage.getInt('task_duration_$taskId') ?? 0;
  }

//============================== Cleanup ==============================
  /// Cancels all active timers when the notifier is disposed
  @override
  void dispose() {
    _timers.forEach((taskId, timer) {
      timer.cancel();
    });
    super.dispose();
  }
}

