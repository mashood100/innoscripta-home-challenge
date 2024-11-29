import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectStatus status;
  final List<Project> projects;
  final String errorMessage;

  const ProjectState({
    required this.status,
    required this.projects,
    this.errorMessage = '',
  });

  factory ProjectState.initial() {
    return const ProjectState(
      status: ProjectStatus.initial,
      projects: [],
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    List<Project>? projects,
    String? errorMessage,
  }) {
    return ProjectState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, projects, errorMessage];
}