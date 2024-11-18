import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/domain/repository/project/projects_repository.dart';
import '../../../../fixtures/project/project_fixtures.dart';
import 'projects_repository_test.mocks.dart';

@GenerateMocks([ProjectsRepository])
void main() {
  late MockProjectsRepository repository;

  setUp(() {
    repository = MockProjectsRepository();
  });

  group('ProjectsRepository', () {
    test('create should return a Project', () async {
      final project = ProjectFixtures.mockProject();
      when(repository.create(project)).thenAnswer((_) async => project);

      final result = await repository.create(project);
      verify(repository.create(project)).called(1);
      expect(result, equals(project));
    });

    test('update should return updated Project', () async {
      final project = ProjectFixtures.mockProject();
      when(repository.update(project)).thenAnswer((_) async => project);

      final result = await repository.update(project);
      verify(repository.update(project)).called(1);
      expect(result, equals(project));
    });

    test('delete should complete successfully', () async {
      final projectId = 'test-id-1';
      when(repository.delete(projectId)).thenAnswer((_) async => null);

      await repository.delete(projectId);
      verify(repository.delete(projectId)).called(1);
    });

    test('get should return a Project', () async {
      final project = ProjectFixtures.mockProject();
      when(repository.get(project.id!)).thenAnswer((_) async => project);

      final result = await repository.get(project.id!);
      verify(repository.get(project.id!)).called(1);
      expect(result, equals(project));
    });

    test('getAll should return list of Projects', () async {
      final projects = ProjectFixtures.mockProjectList();
      when(repository.getAll()).thenAnswer((_) async => projects);

      final result = await repository.getAll();
      verify(repository.getAll()).called(1);
      expect(result, equals(projects));
    });
  });
}
