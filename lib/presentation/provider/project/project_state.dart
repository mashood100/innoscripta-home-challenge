import 'package:equatable/equatable.dart';
import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

enum ProjectProviderState { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectProviderState status;
  final List<Project> projects;
  final String errorMessage;

  const ProjectState({
    required this.status,
    required this.projects,
    this.errorMessage = '',
  });

  factory ProjectState.initial() {
    return const ProjectState(
      status: ProjectProviderState.initial,
      projects: [],
    );
  }

  ProjectState copyWith({
    ProjectProviderState? status,
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
