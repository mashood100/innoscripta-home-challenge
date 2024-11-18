import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_home_challenge/data/dto/project/project_dto.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:innoscripta_home_challenge/domain/repository/project/projects_repository.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import '../../../../fixtures/project/project_fixtures.dart';
import '../../repository/project/projects_repository_test.mocks.dart';

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

      await repository.create(project);
      verify(repository.create(project)).called(1);
      expect(project.id, 'test-id-1');
      expect(project.name, 'Test Project');
      expect(project.commentCount, 5);
      expect(project.color, '#FF0000');
      expect(project.isShared, false);
      expect(project.order, 1);
      expect(project.isFavorite, true);
      expect(project.isInboxProject, false);
      expect(project.isTeamInbox, false);
      expect(project.viewStyle, 'list');
      expect(project.url, 'https://test.com/project');
      expect(project.parentId, null);
    });

    test('copyWith should return new instance with updated values', () {
      final project = ProjectFixtures.mockProject();
      final updatedProject = project.copyWith(
        name: 'Updated Project',
        commentCount: 10,
      );

      expect(updatedProject.id, project.id);
      expect(updatedProject.name, 'Updated Project');
      expect(updatedProject.commentCount, 10);
      expect(updatedProject.color, project.color);
    });

    test('toDto should convert Project to ProjectDto', () {
      final project = ProjectFixtures.mockProject();
      final dto = project.toDto();

      expect(dto, isA<ProjectDto>());
      expect(dto.id, project.id);
      expect(dto.name, project.name);
      expect(dto.commentCount, project.commentCount);
    });

    test('fromDto should convert ProjectDto to Project', () {
      final dto = ProjectDto(
        id: 'test-id',
        name: 'Test DTO',
        commentCount: 3,
        color: '#0000FF',
      );

      final project = Project.fromDto(dto);

      expect(project, isA<Project>());
      expect(project.id, dto.id);
      expect(project.name, dto.name);
      expect(project.commentCount, dto.commentCount);
      expect(project.color, dto.color);
    });

    test('props should contain all properties', () {
      final project = ProjectFixtures.mockProject();
      expect(
        project.props,
        [
          project.id,
          project.name,
          project.commentCount,
          project.color,
          project.isShared,
          project.order,
          project.isFavorite,
          project.isInboxProject,
          project.isTeamInbox,
          project.viewStyle,
          project.url,
          project.parentId,
        ],
      );
    });
  });
}
