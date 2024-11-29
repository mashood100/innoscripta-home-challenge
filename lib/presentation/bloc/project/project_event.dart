import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

abstract class ProjectEvent {}

class GetAllProjectsEvent extends ProjectEvent {}

class CreateProjectEvent extends ProjectEvent {
  final Project project;
  CreateProjectEvent(this.project);
}

class UpdateProjectEvent extends ProjectEvent {
  final Project project;
  UpdateProjectEvent(this.project);
}

class DeleteProjectEvent extends ProjectEvent {
  final String projectId;
  DeleteProjectEvent(this.projectId);
}
