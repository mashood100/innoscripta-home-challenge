import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

class TaskFixtures {
  static Task mockTask() {
    return Task(
      id: 'task-1',
      content: 'Test Task',
      description: 'Test Description',
      commentCount: 3,
      isCompleted: false,
      order: 1,
      priority: 1,
      projectId: 'project-1',
      labels: ['label1', 'label2'],

      sectionId: 'section-1',
      parentId: null,
      creatorId: 'creator-1',
      createdAt: DateTime(2024, 1, 1),
      assigneeId: 'assignee-1',
      assignerId: 'assigner-1',
      url: 'https://test.com/task',
      durationInMinutes: 60,
    );
  }

  static List<Task> mockTaskList() {
    return [
      mockTask(),
      Task(
        id: 'task-2',
        content: 'Second Task',
        description: 'Second Description',
        commentCount: 0,
        isCompleted: true,
        order: 2,
        priority: 2,
        projectId: 'project-1',
        durationInMinutes: 30,
      ),
    ];
  }

  static String mockTaskJson() {
    return '{"id":"task-1","content":"Test Task"}';
  }

  static List<String> mockTaskJsonList() {
    return [
      mockTaskJson(),
      '{"id":"task-2","content":"Second Task"}',
    ];
  }
}