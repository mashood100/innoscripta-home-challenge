import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

abstract class ProjectsRepository {
  Future<Project> create(Project project);
  Future<Project> update(Project project);
  Future<void> delete(String? id);
  Future<Project> get(String id);
  Future<List<Project>> getAll();
}
