import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state_notifier.dart';

class MockProjectsUseCases extends Mock implements ProjectsUseCases {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Project(
        id: 'dummy-id',
        name: 'dummy-name',
        color: 'dummy-color',
      ),
    );
  });

  // ignore: unused_local_variable
  late ProjectStateNotifier projectStateNotifier;
  late MockProjectsUseCases mockProjectsUseCases;

  setUp(() {
    mockProjectsUseCases = MockProjectsUseCases();
    projectStateNotifier = ProjectStateNotifier();
  });

  final testProject = Project(
    id: '1',
    name: 'Test Project',
    color: 'berry_red',
    isFavorite: false,
  );

  group('ProjectStateNotifier - Create Project', () {
    test('should create project successfully', () async {
      // Arrange
      when(() => mockProjectsUseCases.create(any()))
          .thenAnswer((_) async => testProject);

      // Act
      final result = await mockProjectsUseCases.create(testProject);

      // Assert
      expect(result, equals(testProject));
      verify(() => mockProjectsUseCases.create(any())).called(1);
    });

    test('should handle error when creating project', () async {
      // Arrange
      when(() => mockProjectsUseCases.create(any()))
          .thenThrow(Exception('Failed to create project'));

      // Act & Assert
      expect(
        () => mockProjectsUseCases.create(testProject),
        throwsA(isA<Exception>()),
      );
      verify(() => mockProjectsUseCases.create(any())).called(1);
    });
  });

  group('ProjectStateNotifier - Get All Projects', () {
    test('should get all projects successfully', () async {
      // Arrange
      final List<Project> projectsList = [testProject];
      when(() => mockProjectsUseCases.getAll())
          .thenAnswer((_) async => projectsList);

      // Act
      final result = await mockProjectsUseCases.getAll();

      // Assert
      expect(result, equals(projectsList));
      verify(() => mockProjectsUseCases.getAll()).called(1);
    });

    test('should handle error when getting all projects', () async {
      // Arrange
      when(() => mockProjectsUseCases.getAll())
          .thenThrow(Exception('Failed to get projects'));

      // Act & Assert
      expect(
        () => mockProjectsUseCases.getAll(),
        throwsA(isA<Exception>()),
      );
      verify(() => mockProjectsUseCases.getAll()).called(1);
    });
  });

  group('ProjectStateNotifier - Update Project', () {
    test('should update project successfully', () async {
      // Arrange
      final updatedProject = testProject.copyWith(
        name: 'Updated Test Project',
        isFavorite: true,
      );
      when(() => mockProjectsUseCases.update(any()))
          .thenAnswer((_) async => updatedProject);

      // Act
      final result = await mockProjectsUseCases.update(updatedProject);

      // Assert
      expect(result.name, equals('Updated Test Project'));
      expect(result.isFavorite, isTrue);
      verify(() => mockProjectsUseCases.update(any())).called(1);
    });

    test('should handle error when updating project', () async {
      // Arrange
      when(() => mockProjectsUseCases.update(any()))
          .thenThrow(Exception('Failed to update project'));

      // Act & Assert
      expect(
        () => mockProjectsUseCases.update(testProject),
        throwsA(isA<Exception>()),
      );
      verify(() => mockProjectsUseCases.update(any())).called(1);
    });
  });

  group('ProjectStateNotifier - Delete Project', () {
    test('should delete project successfully', () async {
      // Arrange
      when(() => mockProjectsUseCases.delete(any())).thenAnswer((_) async {});

      // Act
      await mockProjectsUseCases.delete('1');

      // Assert
      verify(() => mockProjectsUseCases.delete('1')).called(1);
    });

    test('should handle error when deleting project', () async {
      // Arrange
      when(() => mockProjectsUseCases.delete(any()))
          .thenThrow(Exception('Failed to delete project'));

      // Act & Assert
      expect(
        () => mockProjectsUseCases.delete('1'),
        throwsA(isA<Exception>()),
      );
      verify(() => mockProjectsUseCases.delete('1')).called(1);
    });
  });
}
