import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

abstract class TimerEvent {}

class StartTimerEvent extends TimerEvent {
  final Task task;
  StartTimerEvent(this.task);
}

class PauseTimerEvent extends TimerEvent {
  final String taskId;
  PauseTimerEvent(this.taskId);
}

class ResetTimerEvent extends TimerEvent {
  final String taskId;
  ResetTimerEvent(this.taskId);
}

class TimerTickEvent extends TimerEvent {
  final String taskId;
  TimerTickEvent(this.taskId);
}

class RestoreTimerStateEvent extends TimerEvent {}