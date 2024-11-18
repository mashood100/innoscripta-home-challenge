import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/data/repository/task/tasks_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/task/tasks_api_service.dart';
import '../../../../fixtures/task/task_fixtures.dart';
import '../../../../fixtures/task/task_dto_fixtures.dart';
import 'tasks_repository_impl_test.mocks.dart';

@GenerateMocks([TasksApiService])
void main() {
  late TasksRepositoryImpl repository;
  late MockTasksApiService mockApiService;

  setUp(() {
    mockApiService = MockTasksApiService();
    repository = TasksRepositoryImpl(api: mockApiService);
  });

  group('TasksRepositoryImpl', () {
    test('create should return Task from API response', () async {
      final task = TaskFixtures.mockTask();
      when(mockApiService.create(any))
          .thenAnswer((_) async => TaskDtoFixtures.mockTaskJson());

      final result = await repository.create(task);
      verify(mockApiService.create(any)).called(1);
      expect(result.id, 'task-1');
      expect(result.content, 'Test Task');
    });

    test('getAll should return list of Tasks', () async {
      when(mockApiService.getAll('project-1'))
          .thenAnswer((_) async => TaskDtoFixtures.mockTaskListJson());

      final result = await repository.getAll('project-1');
      verify(mockApiService.getAll('project-1')).called(1);
      expect(result.length, 2);
      expect(result.first.id, 'task-1');
      expect(result.first.content, 'Test Task');
    });

    test('should throw exception when API fails', () async {
      when(mockApiService.getAll('project-1'))
          .thenThrow(Exception('API Error'));

      expect(() => repository.getAll('project-1'), throwsException);
      verify(mockApiService.getAll('project-1')).called(1);
    });
  });
}