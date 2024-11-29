
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_home_challenge/domain/use_cases/project/projects_use_cases.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_event.dart';
import 'package:innoscripta_home_challenge/presentation/bloc/project/project_state.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectsUseCases _projectUseCase;

  ProjectBloc({required ProjectsUseCases projectUseCase})
      : _projectUseCase = projectUseCase,
        super(ProjectState.initial()) {
    on<GetAllProjectsEvent>(_getAllProjects);
    on<CreateProjectEvent>(_createProject);
    on<UpdateProjectEvent>(_updateProject);
    on<DeleteProjectEvent>(_deleteProject);
  }

  Future<void> _getAllProjects(
    GetAllProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProjectStatus.loading));
      final projects = await _projectUseCase.getAll();

      final filteredProjects = 
          projects.where((p) => p.id != "2343546180").toList();

      emit(state.copyWith(
        status: ProjectStatus.success,
        projects: filteredProjects,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _createProject(
    CreateProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      final response = await _projectUseCase.create(event.project);
      final updatedProjects = [response, ...state.projects];
      
      emit(state.copyWith(projects: updatedProjects));
      SnackbarHelper.snackbarWithTextOnly('Project created successfully');
    } catch (error) {
      SnackbarHelper.snackbarWithTextOnly('Failed to create new project');
      log('Create project error: $error');
    }
  }

  Future<void> _updateProject(
    UpdateProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    final initialState = state;
    try {
      final updatedProjects = state.projects.map((p) {
        return p.id == event.project.id ? event.project : p;
      }).toList();

      emit(state.copyWith(projects: updatedProjects));
      await _projectUseCase.update(event.project);
      SnackbarHelper.snackbarWithTextOnly('Project updated successfully');
    } catch (e) {
      emit(initialState);
      SnackbarHelper.snackbarWithTextOnly('Failed to update project');
      log('Update project error: $e');
    }
  }

  Future<void> _deleteProject(
    DeleteProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      await _projectUseCase.delete(event.projectId);
      
      final updatedProjects = 
          state.projects.where((p) => p.id != event.projectId).toList();
      
      emit(state.copyWith(
        status: ProjectStatus.success,
        projects: updatedProjects,
      ));
      
      SnackbarHelper.snackbarWithTextOnly('Project deleted successfully');
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.error,
        errorMessage: e.toString(),
      ));
      SnackbarHelper.snackbarWithTextOnly('Failed to delete project');
      log('Delete project error: $e');
    }
  }
}