import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/task_storage_repository.dart';
import '../../../../fixtures/task/task_fixtures.dart';
import 'task_storage_repository_test.mocks.dart';

@GenerateMocks([TaskStorageRepository])
void main() {
  late MockTaskStorageRepository repository;

  setUp(() {
    repository = MockTaskStorageRepository();
  });

  group('TaskStorageRepository', () {
    test('saveClosedTasks should complete successfully', () async {
      final tasks = TaskFixtures.mockTaskJsonList();
      when(repository.saveClosedTasks(tasks)).thenAnswer((_) async => null);

      await repository.saveClosedTasks(tasks);
      verify(repository.saveClosedTasks(tasks)).called(1);
    });

    test('getClosedTasks should return list of task jsons', () async {
      final tasks = TaskFixtures.mockTaskJsonList();
      when(repository.getClosedTasks()).thenAnswer((_) async => tasks);

      final result = await repository.getClosedTasks();
      verify(repository.getClosedTasks()).called(1);
      expect(result, equals(tasks));
    });

    test('clearClosedTasks should complete successfully', () async {
      when(repository.clearClosedTasks()).thenAnswer((_) async => null);

      await repository.clearClosedTasks();
      verify(repository.clearClosedTasks()).called(1);
    });
  });
}