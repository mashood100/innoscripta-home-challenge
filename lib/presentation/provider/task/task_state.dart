import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

enum TaskProviderState {
  initial,
  loading,
  success,
}
enum CompletedTaskState {
  initial,
  loading,
  success,
}
class TaskState extends Equatable {
  final TaskProviderState status;
  final CompletedTaskState completedTaskStatus;
  final List<Task> tasks;
  final List<Task> closedTasks;
  final Map<String, int> taskDurations;
  final String? errorMessage;

  const TaskState({
    required this.status,
    required this.completedTaskStatus,
    required this.tasks,
    required this.closedTasks,
    required this.taskDurations,
    this.errorMessage,
  });

  factory TaskState.initial() {
    return const TaskState(
      status: TaskProviderState.initial,
      completedTaskStatus: CompletedTaskState.initial,
      tasks: [],
      closedTasks: [],
      taskDurations: {},
    );
  }

  TaskState copyWith({
    TaskProviderState? status,
    CompletedTaskState? completedTaskStatus,
    List<Task>? tasks,
    List<Task>? closedTasks,
    Map<String, int>? taskDurations,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      completedTaskStatus: completedTaskStatus ?? this.completedTaskStatus,
      tasks: tasks ?? this.tasks,
      closedTasks: closedTasks ?? this.closedTasks,
      taskDurations: taskDurations ?? this.taskDurations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, completedTaskStatus, tasks, closedTasks, taskDurations, errorMessage];
}
