import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

class TaskProviderFixtures {
  
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