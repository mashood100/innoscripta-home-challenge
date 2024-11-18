import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/data/repository/project/projects_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/project/projects_api_service.dart';
import '../../../../fixtures/project/project_dto_fixtures.dart';
import '../../../../fixtures/project/project_fixtures.dart';
import 'projects_repository_impl_test.mocks.dart';

@GenerateMocks([ProjectsApiService])
void main() {
  late ProjectsRepositoryImpl repository;
  late MockProjectsApiService mockApiService;

  setUp(() {
    mockApiService = MockProjectsApiService();
    repository = ProjectsRepositoryImpl(api: mockApiService);
  });

  group('ProjectsRepositoryImpl', () {
    test('create should return Project from API response', () async {
      final project = ProjectFixtures.mockProject();
      when(mockApiService.create(any))
          .thenAnswer((_) async => ProjectDtoFixtures.mockProjectJson());

      final result = await repository.create(project);
      verify(mockApiService.create(any)).called(1);
      expect(result.id, 'test-id-1');
      expect(result.name, 'Test Project');
    });

    test('getAll should return list of Projects', () async {
      when(mockApiService.getAll())
          .thenAnswer((_) async => ProjectDtoFixtures.mockProjectListJson());

      final result = await repository.getAll();
      verify(mockApiService.getAll()).called(1);
      expect(result.length, 2);
      expect(result.first.id, 'test-id-1');
    });

    test('should throw exception when API fails', () async {
      when(mockApiService.getAll()).thenThrow(Exception('API Error'));

      expect(() => repository.getAll(), throwsException);
      verify(mockApiService.getAll()).called(1);
    });
  });
}
