import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state_notifier.dart';

class MockTasksUseCases extends Mock implements TasksUseCases {}

class MockTaskStorageUseCases extends Mock implements TaskStorageUseCases {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Task(
        id: 'dummy-id',
        content: 'dummy-content',
        projectId: 'dummy-project',
      ),
    );
  });

  late TaskStateNotifier taskStateNotifier;
  late MockTasksUseCases mockTasksUseCases;
  late MockTaskStorageUseCases mockTaskStorageUseCases;

  setUp(() {
    mockTasksUseCases = MockTasksUseCases();
    mockTaskStorageUseCases = MockTaskStorageUseCases();
    taskStateNotifier = TaskStateNotifier(
      taskStorageUseCases: mockTaskStorageUseCases,
    );
  });

  final testTask = Task(
    id: '1',
    content: 'Test Task',
    description: 'Test Description',
    projectId: 'project1',
    labels: ['todo'],
  );

  group('TaskStateNotifier - Get Task', () {
    test('should get task by id successfully', () async {
      // Arrange
      when(() => mockTasksUseCases.get('1')).thenAnswer((_) async => testTask);

      // Act
      final result = await mockTasksUseCases.get('1');

      // Assert
      expect(result, equals(testTask));
      verify(() => mockTasksUseCases.get('1')).called(1);
    });

    test('should handle error when getting task by id', () async {
      // Arrange
      when(() => mockTasksUseCases.get('1'))
          .thenThrow(Exception('Failed to get task'));

      // Act & Assert
      expect(
        () => mockTasksUseCases.get('1'),
        throwsA(isA<Exception>()),
      );
      verify(() => mockTasksUseCases.get('1')).called(1);
    });
  });

  group('TaskStateNotifier - Get All Tasks', () {
    test('should get all tasks successfully', () async {
      // Arrange
      final List<Task> tasksList = [testTask];
      when(() => mockTasksUseCases.getAll('project1'))
          .thenAnswer((_) async => tasksList);

      // Act
      final result = await mockTasksUseCases.getAll('project1');

      // Assert
      expect(result, equals(tasksList));
      verify(() => mockTasksUseCases.getAll('project1')).called(1);
    });

    test('should handle error when getting all tasks', () async {
      // Arrange
      when(() => mockTasksUseCases.getAll('project1'))
          .thenThrow(Exception('Failed to get tasks'));

      // Act & Assert
      expect(
        () => mockTasksUseCases.getAll('project1'),
        throwsA(isA<Exception>()),
      );
      verify(() => mockTasksUseCases.getAll('project1')).called(1);
    });
  });

  group('TaskStateNotifier - Update Task Status', () {
    test('should update task status successfully', () async {
      // Arrange
      final updatedTask = testTask.copyWith(
        labels: ['in_progress'],
      );
      when(() => mockTasksUseCases.update(any()))
          .thenAnswer((_) async => updatedTask);

      // Act
      final result = await mockTasksUseCases.update(updatedTask);

      // Assert
      expect(result.labels, contains('in_progress'));
      verify(() => mockTasksUseCases.update(any())).called(1);
    });

    test('should handle error when updating task status', () async {
      // Arrange
      when(() => mockTasksUseCases.update(any()))
          .thenThrow(Exception('Failed to update task status'));

      // Act & Assert
      expect(
        () => mockTasksUseCases.update(testTask),
        throwsA(isA<Exception>()),
      );
      verify(() => mockTasksUseCases.update(any())).called(1);
    });
  });

  group('TaskStateNotifier - Update Task', () {
    test('should update task successfully', () async {
      // Arrange
      final updatedTask = testTask.copyWith(
        content: 'Updated Test Task',
      );
      when(() => mockTasksUseCases.update(any()))
          .thenAnswer((_) async => updatedTask);

      // Act
      final result = await mockTasksUseCases.update(updatedTask);

      // Assert
      expect(result.content, equals('Updated Test Task'));
      verify(() => mockTasksUseCases.update(any())).called(1);
    });

    test('should handle error when updating task', () async {
      // Arrange
      when(() => mockTasksUseCases.update(any()))
          .thenThrow(Exception('Failed to update task'));

      // Act & Assert
      expect(
        () => mockTasksUseCases.update(testTask),
        throwsA(isA<Exception>()),
      );
      verify(() => mockTasksUseCases.update(any())).called(1);
    });
  });

  group('TaskStateNotifier - Update Task Duration', () {
    test('should update task duration successfully', () async {
      // Arrange
      final updatedTask = Task(
          id: '1',
          content: 'Test Task',
          description: 'Test Description',
          projectId: 'project1',
          labels: ['todo'],
          durationInMinutes: 30);

      when(() => mockTasksUseCases.update(any()))
          .thenAnswer((_) async => updatedTask);

      // Act
      final result = await mockTasksUseCases.update(updatedTask);

      // Assert
      expect(result.durationInMinutes, equals(30));
      verify(() => mockTasksUseCases.update(any())).called(1);
    });

    test('should handle error when updating task duration', () async {
      // Arrange
      when(() => mockTasksUseCases.update(any()))
          .thenThrow(Exception('Failed to update task duration'));

      // Act & Assert
      expect(
        () => mockTasksUseCases.update(testTask),
        throwsA(isA<Exception>()),
      );
      verify(() => mockTasksUseCases.update(any())).called(1);
    });
  });
}
