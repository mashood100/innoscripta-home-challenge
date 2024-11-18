import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import '../../../../fixtures/task/task_fixtures.dart';
import '../../repository/task/tasks_repository_test.mocks.dart';

void main() {
  late TasksUseCases useCase;
  late MockTasksRepository mockRepository;

  setUp(() {
    mockRepository = MockTasksRepository();
    useCase = TasksUseCases(repository: mockRepository);
  });

  group('TasksUseCases', () {
    test('create should return created Task', () async {
      final task = TaskFixtures.mockTask();
      when(mockRepository.create(task)).thenAnswer((_) async => task);

      final result = await useCase.create(task);
      verify(mockRepository.create(task)).called(1);
      expect(result, equals(task));
    });

    test('create should rethrow exception', () async {
      final task = TaskFixtures.mockTask();
      when(mockRepository.create(task)).thenThrow(Exception('Error'));

      expect(() => useCase.create(task), throwsException);
      verify(mockRepository.create(task)).called(1);
    });

    test('close should complete successfully', () async {
      final task = TaskFixtures.mockTask();
      when(mockRepository.delete(task)).thenAnswer((_) async => null);

      await useCase.close(task);
      verify(mockRepository.delete(task)).called(1);
    });

    test('getAll should return list of Tasks', () async {
      final tasks = TaskFixtures.mockTaskList();
      final projectId = 'project-1';
      when(mockRepository.getAll(projectId)).thenAnswer((_) async => tasks);

      final result = await useCase.getAll(projectId);
      verify(mockRepository.getAll(projectId)).called(1);
      expect(result, equals(tasks));
    });
  });
}