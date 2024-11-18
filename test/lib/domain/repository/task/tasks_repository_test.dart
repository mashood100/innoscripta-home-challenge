import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/tasks_repository.dart';
import '../../../../fixtures/task/task_fixtures.dart';
import 'tasks_repository_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late MockTasksRepository repository;

  setUp(() {
    repository = MockTasksRepository();
  });

  group('TasksRepository', () {
    test('create should return a Task', () async {
      final task = TaskFixtures.mockTask();
      when(repository.create(task)).thenAnswer((_) async => task);

      final result = await repository.create(task);
      verify(repository.create(task)).called(1);
      expect(result, equals(task));
    });

    test('update should return updated Task', () async {
      final task = TaskFixtures.mockTask();
      when(repository.update(task)).thenAnswer((_) async => task);

      final result = await repository.update(task);
      verify(repository.update(task)).called(1);
      expect(result, equals(task));
    });

    test('delete should complete successfully', () async {
      final task = TaskFixtures.mockTask();
      when(repository.delete(task)).thenAnswer((_) async => null);

      await repository.delete(task);
      verify(repository.delete(task)).called(1);
    });

    test('close should complete successfully', () async {
      final task = TaskFixtures.mockTask();
      when(repository.close(task)).thenAnswer((_) async => null);

      await repository.close(task);
      verify(repository.close(task)).called(1);
    });

    test('getAll should return list of Tasks', () async {
      final tasks = TaskFixtures.mockTaskList();
      final projectId = 'project-1';
      when(repository.getAll(projectId)).thenAnswer((_) async => tasks);

      final result = await repository.getAll(projectId);
      verify(repository.getAll(projectId)).called(1);
      expect(result, equals(tasks));
    });
  });
}