import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import '../task/task_fixtures.dart';

class TaskProviderFixtures {
  static TaskState mockInitialState() {
    return TaskState.initial();
  }

  static TaskState mockLoadedState() {
    return TaskState(
      status: TaskProviderState.success,
      completedTaskStatus: CompletedTaskState.initial,
      tasks: TaskFixtures.mockTaskList(),
      closedTasks: [],
      taskDurations: {
        'task-1': 60,
        'task-2': 30,
      },
    );
  }

  static Task mockNewTask() {
    return Task(
      id: 'new-task-1',
      content: 'New Test Task',
      description: 'New Task Description',
      commentCount: 0,
      isCompleted: false,
      order: 3,
      priority: 2,
      projectId: 'project-1',
      durationInMinutes: 45,
    );
  }
}