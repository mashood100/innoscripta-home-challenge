import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innoscripta_home_challenge/data/repository/project/projects_repository_impl.dart';
import 'package:innoscripta_home_challenge/data/source/network/project/projects_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/provider/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class ProjectStateNotifier extends StateNotifier<ProjectState> {
  ProjectStateNotifier()
      : _projectUseCase = ProjectsUseCases(
          repository: ProjectsRepositoryImpl(api: ProjectsApiService()),
        ),
        super(ProjectState.initial());

  final ProjectsUseCases _projectUseCase;

//============================== Create Project ==============================
  /// Creates a new project and adds it to the top of the projects list
  Future<void> createProject(Project project) async {
    try {
      Project response = await _projectUseCase.create(project);

      final updatedProjects = [response, ...state.projects];
      state = state.copyWith(
        projects: updatedProjects,
      );

      SnackbarHelper.snackbarWithTextOnly('Project created successfully');
    } catch (error) {
      SnackbarHelper.snackbarWithTextOnly('Failed to create new project');
      log('Create project error: $error');
    }
  }
//============================== All Projects ==============================
  /// Fetches all projects from the API and filters out the default project

  Future<void> getAllProjects() async {
    try {
      state = state.copyWith(status: ProjectProviderState.loading);
      final projects = await _projectUseCase.getAll();

      // Filter out default project
      final filteredProjects =
          projects.where((p) => p.id != "2343546180").toList();

      state = state.copyWith(
        status: ProjectProviderState.success,
        projects: filteredProjects,
      );
    } catch (e) {
      state = state.copyWith(
        status: ProjectProviderState.error,
        errorMessage: e.toString(),
      );
    }
  }
//============================== Delete Projects ==============================

  /// Removes a project from the list by its ID
  Future<void> deleteProject(String? projectId) async {
    try {
      await _projectUseCase.delete(projectId);

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

//============================== Update Projects ==============================

  /// Updates an existing project's details with optimistic update pattern
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
