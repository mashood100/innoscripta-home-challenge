import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/presentation/provider/task/task_state.dart';
import '../../../fixtures/task/task_fixtures.dart';

void main() {
  group('TaskState', () {
    test('initial state should have correct values', () {
      final state = TaskState.initial();
      
      expect(state.status, equals(TaskProviderState.initial));
      expect(state.completedTaskStatus, equals(CompletedTaskState.initial));
      expect(state.tasks, isEmpty);
      expect(state.closedTasks, isEmpty);
      expect(state.taskDurations, isEmpty);
      expect(state.errorMessage, isNull);
    });

    test('copyWith should only change specified fields', () {
      final initialState = TaskState.initial();
      final tasks = TaskFixtures.mockTaskList();
      
      final newState = initialState.copyWith(
        status: TaskProviderState.loading,
        tasks: tasks,
      );

      expect(newState.status, equals(TaskProviderState.loading));
      expect(newState.tasks, equals(tasks));
      expect(newState.completedTaskStatus, equals(initialState.completedTaskStatus));
      expect(newState.closedTasks, equals(initialState.closedTasks));
      expect(newState.taskDurations, equals(initialState.taskDurations));
    });

    test('equals should work correctly', () {
      final state1 = TaskState.initial();
      final state2 = TaskState.initial();
      final state3 = state1.copyWith(status: TaskProviderState.loading);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });
  });
}