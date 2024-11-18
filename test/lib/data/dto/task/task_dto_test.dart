import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import '../../../../fixtures/task/task_dto_fixtures.dart';

void main() {
  group('TaskDto', () {
    test('should create TaskDto with default values', () {
      final dto = TaskDto();
      
      expect(dto.id, isNull);
      expect(dto.content, isNull);
      expect(dto.isCompleted, isNull);
      expect(dto.labels, isNull);
    });

    test('fromMap should create TaskDto with correct values', () {
      final map = TaskDtoFixtures.mockTaskMap();
      final dto = TaskDto.fromMap(map);

      expect(dto.id, 'task-1');
      expect(dto.content, 'Test Task');
      expect(dto.description, 'Test Description');
      expect(dto.commentCount, 3);
      expect(dto.isCompleted, false);
      expect(dto.order, 1);
      expect(dto.priority, 1);
      expect(dto.projectId, 'project-1');
      expect(dto.labels, ['label1', 'label2']);
      expect(dto.due?.date, '2024-03-20');
      expect(dto.duration?.amount, 60);
      expect(dto.duration?.unit, 'minutes');
    });

    test('toMap should convert TaskDto to Map correctly', () {
      final map = TaskDtoFixtures.mockTaskMap();
      final dto = TaskDto.fromMap(map);
      final resultMap = dto.toMap();

      expect(resultMap['id'], 'task-1');
      expect(resultMap['content'], 'Test Task');
      expect(resultMap['description'], 'Test Description');
      expect(resultMap['comment_count'], 3);
      expect(resultMap['duration']['amount'], 60);
      expect(resultMap['duration']['unit'], 'minutes');
    });

    test('copyWith should return new instance with updated values', () {
      final dto = TaskDto(id: 'task-1', content: 'Test Task');
      final updated = dto.copyWith(content: 'Updated Task');

      expect(updated.id, 'task-1');
      expect(updated.content, 'Updated Task');
    });
  });

  group('Due', () {
    test('should create Due with correct values', () {
      final map = TaskDtoFixtures.mockTaskMap()['due'] as Map<String, dynamic>;
      final due = Due.fromMap(map);

      expect(due.date, '2024-03-20');
      expect(due.string, 'tomorrow');
      expect(due.lang, 'en');
      expect(due.isRecurring, false);
      expect(due.datetime, '2024-03-20T10:00:00Z');
    });
  });

  group('TaskDuration', () {
    test('should create TaskDuration with correct values', () {
      final map = TaskDtoFixtures.mockTaskMap()['duration'] as Map<String, dynamic>;
      final duration = TaskDuration.fromMap(map);

      expect(duration.amount, 60);
      expect(duration.unit, 'minutes');
    });
  });
}