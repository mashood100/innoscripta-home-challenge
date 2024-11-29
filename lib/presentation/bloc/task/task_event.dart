import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

abstract class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final Task task;
  CreateTaskEvent(this.task);
}

class GetAllTasksEvent extends TaskEvent {
  final String projectId;
  GetAllTasksEvent(this.projectId);
}

class UpdateTaskStatusEvent extends TaskEvent {
  final Task task;
  final String newStatus;
  UpdateTaskStatusEvent(this.task, this.newStatus);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

class UpdateTaskDurationEvent extends TaskEvent {
  final String taskId;
  final int seconds;
  UpdateTaskDurationEvent(this.taskId, this.seconds);
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;
  DeleteTaskEvent(this.task);
}

class LoadClosedTasksEvent extends TaskEvent {}

class CloseTaskEvent extends TaskEvent {
  final Task task;
  CloseTaskEvent(this.task);
}

class ClearTasksEvent extends TaskEvent {}