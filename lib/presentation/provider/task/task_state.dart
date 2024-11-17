import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

enum TaskProviderState {
  initial,
  loading,
  success,
}

class TaskState extends Equatable {
  final TaskProviderState status;
  final List<Task> tasks;
  final String errorMessage;
  final Map<String, int> taskDurations;

  const TaskState({
    required this.status,
    required this.tasks,
    this.errorMessage = '',
    this.taskDurations = const {},
  });

  factory TaskState.initial() {
    return const TaskState(
      status: TaskProviderState.initial,
      tasks: [],
      taskDurations: {},
    );
  }

  TaskState copyWith({
    TaskProviderState? status,
    List<Task>? tasks,
    String? errorMessage,
    Map<String, int>? taskDurations,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      taskDurations: taskDurations ?? this.taskDurations,
    );
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage, taskDurations];
}
