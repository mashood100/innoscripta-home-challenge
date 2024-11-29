import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_bloc.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_state.dart';
import '../../../fixtures/project/project_fixtures.dart';

class MockProjectsUseCases extends Mock implements ProjectsUseCases {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(ProjectFixtures.mockFallbackProject());
  });

  late ProjectBloc projectBloc;
  late MockProjectsUseCases mockProjectsUseCases;

  setUp(() {
    mockProjectsUseCases = MockProjectsUseCases();
    projectBloc = ProjectBloc(projectUseCase: mockProjectsUseCases);
  });

  tearDown(() {
    projectBloc.close();
  });

  group('ProjectBloc - Create Project', () {
    final testProject = ProjectFixtures.mockProject();

    blocTest<ProjectBloc, ProjectState>(
      'emits successful state when project is created',
      build: () {
        when(() => mockProjectsUseCases.create(any()))
            .thenAnswer((_) async => testProject);
        return projectBloc;
      },
      act: (bloc) => bloc.add(CreateProjectEvent(testProject)),
      expect: () => [
        isA<ProjectState>().having(
          (state) => state.projects,
          'projects',
          [testProject],
        ),
      ],
      verify: (_) {
        verify(() => mockProjectsUseCases.create(testProject)).called(1);
      },
    );
  });

  group('ProjectBloc - Get All Projects', () {
    final testProjects = ProjectFixtures.mockProjectList();

    blocTest<ProjectBloc, ProjectState>(
      'emits loading and success states with filtered projects',
      build: () {
        when(() => mockProjectsUseCases.getAll())
            .thenAnswer((_) async => testProjects);
        return projectBloc;
      },
      act: (bloc) => bloc.add(GetAllProjectsEvent()),
      expect: () => [
        isA<ProjectState>().having(
          (state) => state.status,
          'status',
          ProjectStatus.loading,
        ),
        isA<ProjectState>()
            .having((state) => state.status, 'status', ProjectStatus.success)
            .having((state) => state.projects, 'projects', testProjects),
      ],
    );
  });

  group('ProjectBloc - Update Project', () {
    final initialProject = ProjectFixtures.mockProject();
    final updatedProject = ProjectFixtures.mockUpdatedProject();

    blocTest<ProjectBloc, ProjectState>(
      'emits state with updated project on successful update',
      setUp: () {
        projectBloc.emit(ProjectState.initial().copyWith(
          projects: [initialProject],
        ));
        when(() => mockProjectsUseCases.update(any()))
            .thenAnswer((_) async => updatedProject);
      },
      build: () => projectBloc,
      act: (bloc) => bloc.add(UpdateProjectEvent(updatedProject)),
      expect: () => [
        isA<ProjectState>().having(
          (state) => state.projects,
          'projects',
          [updatedProject],
        ),
      ],
    );
  });

  group('ProjectBloc - Delete Project', () {
    final testProject = ProjectFixtures.mockProject();

    blocTest<ProjectBloc, ProjectState>(
      'emits state without deleted project on successful deletion',
      setUp: () {
        projectBloc.emit(ProjectState.initial().copyWith(
          projects: [testProject],
        ));
        when(() => mockProjectsUseCases.delete(any())).thenAnswer((_) async {});
      },
      build: () => projectBloc,
      act: (bloc) => bloc.add(DeleteProjectEvent(testProject.id!)),
      expect: () => [
        isA<ProjectState>()
            .having((state) => state.status, 'status', ProjectStatus.success)
            .having((state) => state.projects, 'projects', isEmpty),
      ],
    );
  });
}