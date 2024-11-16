import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

enum TaskProviderState { initial, loading, success, error }

class TaskState extends Equatable {
  final TaskProviderState status;
  final List<Task> tasks;
  final String errorMessage;

  const TaskState({
    required this.status,
    required this.tasks,
    this.errorMessage = '',
  });

  factory TaskState.initial() {
    return const TaskState(
      status: TaskProviderState.initial,
      tasks: [],
    );
  }

  TaskState copyWith({
    TaskProviderState? status,
    List<Task>? tasks,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage];
} 