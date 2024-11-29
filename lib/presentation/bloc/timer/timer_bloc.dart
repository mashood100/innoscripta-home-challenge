import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/main.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/timer/timer_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/timer/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Map<String, Timer> _timers = {};
  final TaskBloc _taskBloc;

  TimerBloc({required TaskBloc taskBloc})
      : _taskBloc = taskBloc,
        super(TimerState.initial()) {
    on<StartTimerEvent>(_onStartTimer);
    on<PauseTimerEvent>(_onPauseTimer);
    on<ResetTimerEvent>(_onResetTimer);
    on<TimerTickEvent>(_onTimerTick);
    on<RestoreTimerStateEvent>(_onRestoreState);

    add(RestoreTimerStateEvent());
  }

  Future<void> _onStartTimer(
    StartTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    final taskId = event.task.id!;
    final existingTimer = state.taskTimers[taskId];

    if (existingTimer != null && existingTimer.isPaused) {
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = existingTimer.copyWith(isPaused: false);
      emit(state.copyWith(taskTimers: updatedTimers));
    } else {
      final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
      updatedTimers[taskId] = TaskTimer(
        currentDuration: event.task.duration?.amount ?? 0,
        startTime: DateTime.now(),
      );
      emit(state.copyWith(taskTimers: updatedTimers));
    }

    _timers[taskId]?.cancel();
    _startPeriodicTimer(taskId);
  }

  Future<void> _onPauseTimer(
    PauseTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    _timers[event.taskId]?.cancel();
    _timers.remove(event.taskId);

    final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
    final timer = updatedTimers[event.taskId];
    if (timer != null) {
      updatedTimers[event.taskId] = timer.copyWith(isPaused: true);
      emit(state.copyWith(taskTimers: updatedTimers));
      _saveState();
      _updateTaskDuration(event.taskId, timer.currentDuration);
    }
  }

  Future<void> _onResetTimer(
    ResetTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    _timers[event.taskId]?.cancel();
    _timers.remove(event.taskId);

    final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
    updatedTimers.remove(event.taskId);
    emit(state.copyWith(taskTimers: updatedTimers));

    localStorage.remove('task_duration_${event.taskId}');
    localStorage.remove('timer_${event.taskId}_is_paused');
    localStorage.remove('timer_${event.taskId}_start_time');

    _updateTaskDuration(event.taskId, 0);
  }

  void _onTimerTick(
    TimerTickEvent event,
    Emitter<TimerState> emit,
  ) {
    final currentTimer = state.taskTimers[event.taskId]!;
    final updatedTimers = Map<String, TaskTimer>.from(state.taskTimers);
    updatedTimers[event.taskId] = currentTimer.copyWith(
      currentDuration: currentTimer.currentDuration + 1,
    );
    emit(state.copyWith(taskTimers: updatedTimers));
    _saveState();
  }

  Future<void> _onRestoreState(
    RestoreTimerStateEvent event,
    Emitter<TimerState> emit,
  ) async {
    final tasks = _taskBloc.state.tasks;
    final updatedTimers = <String, TaskTimer>{};

    for (final task in tasks) {
      if (task.id != null) {
        final duration = await _getTaskDuration(task.id!);
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

    emit(TimerState(taskTimers: updatedTimers));
  }

  void _startPeriodicTimer(String taskId) {
    _timers[taskId] = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(TimerTickEvent(taskId)),
    );
  }

  Future<void> _updateTaskDuration(String taskId, int seconds) async {
    _taskBloc.add(UpdateTaskDurationEvent(taskId, seconds));
  }

  Future<void> _saveState() async {
    for (final entry in state.taskTimers.entries) {
      final taskId = entry.key;
      final timer = entry.value;

      await localStorage.setInt('task_duration_$taskId', timer.currentDuration);
      await localStorage.setBool('timer_${taskId}_is_paused', timer.isPaused);

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

  Future<int> _getTaskDuration(String taskId) async {
    return localStorage.getInt('task_duration_$taskId') ?? 0;
  }

  @override
  Future<void> close() {
    _timers.forEach((_, timer) => timer.cancel());
    return super.close();
  }
}
