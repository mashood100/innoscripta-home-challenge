import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final Map<String, TaskTimer> taskTimers;
  final Map<String, int> savedDurations;

  const TimerState({
    this.taskTimers = const {},
    this.savedDurations = const {},
  });

  TimerState copyWith({
    Map<String, TaskTimer>? taskTimers,
    Map<String, int>? savedDurations,
  }) {
    return TimerState(
      taskTimers: taskTimers ?? this.taskTimers,
      savedDurations: savedDurations ?? this.savedDurations,
    );
  }

  @override
  List<Object?> get props => [taskTimers, savedDurations];
}

class TaskTimer {
  final int currentDuration;
  final DateTime? startTime;
  final bool isPaused;

  const TaskTimer({
    this.currentDuration = 0,
    this.startTime,
    this.isPaused = false,
  });

  TaskTimer copyWith({
    int? currentDuration,
    DateTime? startTime,
    bool? isPaused,
  }) {
    return TaskTimer(
      currentDuration: currentDuration ?? this.currentDuration,
      startTime: startTime ?? this.startTime,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}
