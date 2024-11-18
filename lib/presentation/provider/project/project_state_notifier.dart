import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/repository/project/projects_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/project/projects_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class ProjectStateNotifier extends StateNotifier<ProjectState> {
  ProjectStateNotifier({
    required Ref ref,
  })  : _ref = ref,
        _projectUseCase = ProjectsUseCases(
          repository: ProjectsRepositoryImpl(api: ProjectsApiService()),
        ),
        super(ProjectState.initial());

  final Ref _ref;
  final ProjectsUseCases _projectUseCase;

  Future<void> createProject(Project project) async {
    try {
      // state = state.copyWith(
      //   status: ProjectProviderState.initial,
      // );
      Project response = await _projectUseCase.create(project);

      // Add new project at the top of the list
      final updatedProjects = [response, ...state.projects];
      state = state.copyWith(
        projects: updatedProjects,
        // status: ProjectProviderState.initial,
      );

      SnackbarHelper.snackbarWithTextOnly('Project created successfully');
    } catch (error) {
      // state = state.copyWith(
      //   status: ProjectProviderState.initial,
      // );
      SnackbarHelper.snackbarWithTextOnly('Failed to create new project');
      log('Create project error: $error');
    }
  }

  Future<void> getAllProjects() async {
    try {
      state = state.copyWith(status: ProjectProviderState.loading);
      final projects = await _projectUseCase.getAll();
      state = state.copyWith(
        status: ProjectProviderState.success,
        projects: projects,
      );
    } catch (e) {
      state = state.copyWith(
        status: ProjectProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteProject(String? projectId) async {
    try {
      await _projectUseCase.delete(projectId);

      // Remove the project from the list
      final updatedProjects =
          state.projects.where((p) => p.id != projectId).toList();
      state = state.copyWith(
        status: ProjectProviderState.success,
        projects: updatedProjects,
      );

      SnackbarHelper.snackbarWithTextOnly('Project deleted successfully');
    } catch (e) {
      state = state.copyWith(
        status: ProjectProviderState.initial,
        errorMessage: e.toString(),
      );
      SnackbarHelper.snackbarWithTextOnly('Failed to delete project');
      log('Delete project error: $e');
    }
  }

  Future<void> updateProject(Project project) async {
    final initialState = state;

    try {
      final updatedProjects = state.projects.map((p) {
        return p.id == project.id ? project : p;
      }).toList();

      state = state.copyWith(
        projects: updatedProjects,
      );

      await _projectUseCase.update(project);
      SnackbarHelper.snackbarWithTextOnly('Project updated successfully');
    } catch (e) {
      state = initialState;
      SnackbarHelper.snackbarWithTextOnly('Failed to update project');
      log('Update project error: $e');
    }
  }

}
