import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import '../../../../fixtures/task/task_fixtures.dart';

void main() {
  group('Task Entity', () {
    test('should create Task instance with correct values', () {
      final task = TaskFixtures.mockTask();

      expect(task.id, 'task-1');
      expect(task.content, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.commentCount, 3);
      expect(task.isCompleted, false);
      expect(task.order, 1);
      expect(task.priority, 1);
      expect(task.projectId, 'project-1');
      expect(task.labels, ['label1', 'label2']);
      expect(task.durationInMinutes, 60);
    });

    test('toDto should convert Task to TaskDto', () {
      final task = TaskFixtures.mockTask();
      final dto = task.toDto();

      expect(dto, isA<TaskDto>());
      expect(dto.id, task.id);
      expect(dto.content, task.content);
      expect(dto.duration?.amount, task.durationInMinutes);
    });

    test('fromDto should convert TaskDto to Task', () {
      final dto = TaskDto(
        id: 'test-id',
        content: 'Test Content',
        duration: TaskDuration(amount: 30, unit: 'minute'),
      );

      final task = Task.fromDto(dto);

      expect(task, isA<Task>());
      expect(task.id, dto.id);
      expect(task.content, dto.content);
      expect(task.durationInMinutes, dto.duration?.amount);
    });
  });
}
