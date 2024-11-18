import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import '../../../../fixtures/project/project_fixtures.dart';
import '../../repository/project/projects_repository_test.mocks.dart';


void main() {
  late ProjectsUseCases useCase;
  late MockProjectsRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectsRepository();
    useCase = ProjectsUseCases(repository: mockRepository);
  });

  group('ProjectsUseCases', () {
    test('create should return created Project', () async {
      final project = ProjectFixtures.mockProject();
      when(mockRepository.create(project)).thenAnswer((_) async => project);

      final result = await useCase.create(project);
      verify(mockRepository.create(project)).called(1);
      expect(result, equals(project));
    });

    test('create should rethrow exception', () async {
      final project = ProjectFixtures.mockProject();
      when(mockRepository.create(project)).thenThrow(Exception('Error'));

      expect(() => useCase.create(project), throwsException);
      verify(mockRepository.create(project)).called(1);
    });

    test('update should return updated Project', () async {
      final project = ProjectFixtures.mockProject();
      when(mockRepository.update(project)).thenAnswer((_) async => project);

      final result = await useCase.update(project);
      verify(mockRepository.update(project)).called(1);
      expect(result, equals(project));
    });

    test('delete should complete successfully', () async {
      final projectId = 'test-id-1';
      when(mockRepository.delete(projectId)).thenAnswer((_) async => null);

      await useCase.delete(projectId);
      verify(mockRepository.delete(projectId)).called(1);
    });

    test('get should return Project', () async {
      final project = ProjectFixtures.mockProject();
      when(mockRepository.get(project.id!)).thenAnswer((_) async => project);

      final result = await useCase.get(project.id!);
      verify(mockRepository.get(project.id!)).called(1);
      expect(result, equals(project));
    });

    test('getAll should return list of Projects', () async {
      final projects = ProjectFixtures.mockProjectList();
      when(mockRepository.getAll()).thenAnswer((_) async => projects);

      final result = await useCase.getAll();
      verify(mockRepository.getAll()).called(1);
      expect(result, equals(projects));
    });
  });
}