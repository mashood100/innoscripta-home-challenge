import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/tasks_use_cases.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/task/task_storage_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/task/task_state.dart';
import '../../../fixtures/task/task_fixtures.dart';

class MockTasksUseCases extends Mock implements TasksUseCases {}

class MockTaskStorageUseCases extends Mock implements TaskStorageUseCases {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TaskBloc taskBloc;
  late MockTasksUseCases mockTasksUseCases;
  late MockTaskStorageUseCases mockTaskStorageUseCases;

  setUp(() {
    mockTasksUseCases = MockTasksUseCases();
    mockTaskStorageUseCases = MockTaskStorageUseCases();
    registerFallbackValue(TaskFixtures.mockTask());
    taskBloc = TaskBloc(
      taskUseCase: mockTasksUseCases,
      taskStorageUseCases: mockTaskStorageUseCases,
    );
  });

  tearDown(() {
    taskBloc.close();
  });

  group('TaskBloc - Create Task', () {
    final testTask = TaskFixtures.mockTask();

    blocTest<TaskBloc, TaskState>(
      'emits loading and success states when task is created',
      build: () {
        when(() => mockTasksUseCases.create(any()))
            .thenAnswer((_) async => testTask);
        return taskBloc;
      },
      act: (bloc) => bloc.add(CreateTaskEvent(testTask)),
      expect: () => [
        isA<TaskState>()
            .having((state) => state.status, 'status', TaskStatus.loading),
        isA<TaskState>()
            .having((state) => state.status, 'status', TaskStatus.success)
            .having((state) => state.tasks, 'tasks', [testTask]).having(
          (state) => state.taskDurations,
          'taskDurations',
          {testTask.id!: testTask.durationInMinutes ?? 0},
        ),
      ],
    );
  });

  group('TaskBloc - Get All Tasks', () {
    final testTasks = TaskFixtures.mockTaskList();

    blocTest<TaskBloc, TaskState>(
      'emits loading and success states with tasks',
      build: () {
        when(() => mockTasksUseCases.getAll(any()))
            .thenAnswer((_) async => testTasks);
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetAllTasksEvent('project-1')),
      expect: () => [
        isA<TaskState>()
            .having((state) => state.status, 'status', TaskStatus.loading),
        isA<TaskState>()
            .having((state) => state.status, 'status', TaskStatus.success)
            .having((state) => state.tasks, 'tasks', testTasks),
      ],
    );
  });

  group('TaskBloc - Update Task Status', () {
    final testTask = TaskFixtures.mockTask();
    final updatedTask = testTask.copyWith(
      labels: [...testTask.labels!, 'in_progress'],
    );

    blocTest<TaskBloc, TaskState>(
      'emits state with updated task status',
      setUp: () {
        taskBloc.emit(TaskState.initial().copyWith(tasks: [testTask]));
        when(() => mockTasksUseCases.update(any()))
            .thenAnswer((_) async => updatedTask);
      },
      build: () => taskBloc,
      act: (bloc) => bloc.add(UpdateTaskStatusEvent(testTask, 'in_progress')),
      expect: () => [
        isA<TaskState>().having(
          (state) => state.tasks.first.labels,
          'labels',
          contains('in_progress'),
        ),
      ],
    );
  });

  group('TaskBloc - Delete Task', () {
    final testTask = TaskFixtures.mockTask();

    blocTest<TaskBloc, TaskState>(
      'emits state without deleted task',
      setUp: () {
        taskBloc.emit(TaskState.initial().copyWith(
          tasks: [testTask],
          taskDurations: {testTask.id!: testTask.durationInMinutes ?? 0},
        ));
        when(() => mockTasksUseCases.delete(any())).thenAnswer((_) async {});
      },
      build: () => taskBloc,
      act: (bloc) => bloc.add(DeleteTaskEvent(testTask)),
      expect: () => [
        isA<TaskState>()
            .having((state) => state.status, 'status', TaskStatus.success)
            .having((state) => state.tasks, 'tasks', isEmpty)
            .having((state) => state.taskDurations, 'taskDurations', {}),
      ],
    );
  });

  group('TaskBloc - Close Task', () {
    final testTask = TaskFixtures.mockTask();
    final closedTask =
        testTask.copyWith(labels: [...testTask.labels!, 'closed']);

    blocTest<TaskBloc, TaskState>(
      'emits state with closed task moved to closedTasks',
      setUp: () {
        taskBloc.emit(TaskState.initial().copyWith(tasks: [testTask]));
        when(() => mockTasksUseCases.close(any()))
            .thenAnswer((_) async => closedTask);
        when(() => mockTaskStorageUseCases.saveClosedTasks(any()))
            .thenAnswer((_) async {});
      },
      build: () => taskBloc,
      act: (bloc) => bloc.add(CloseTaskEvent(testTask)),
      expect: () => [
        isA<TaskState>()
            .having((state) => state.tasks, 'tasks', isEmpty)
            .having((state) => state.closedTasks, 'closedTasks',
                [closedTask]).having(
          (state) => state.completedTaskStatus,
          'completedTaskStatus',
          CompletedTaskStatus.success,
        ),
      ],
    );
  });
}
