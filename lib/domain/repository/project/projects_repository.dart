import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';

abstract class ProjectsRepository {
  Future<Project> create(Project project);
  Future<List<Project>> update(List<String?> ids, Map<String, dynamic> payload);
  Future<void> delete(List<String?> ids);
  Future<Project> get(String id);
  Future<List<Project>> getAll();
}
