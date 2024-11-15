import 'package:innoscripta_home_challenge/domain/entity/project/project.dart';
import 'package:innoscripta_home_challenge/domain/repository/project/projects_repository.dart';

class ProjectsUseCases {
  ProjectsUseCases({
    required ProjectsRepository repository,
  }) : _repository = repository;

  final ProjectsRepository _repository;

  Future<Project> create(Project project) async {
    try {
      return await _repository.create(project);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Project>> update(
      List<String?> ids, Map<String, dynamic> payload) async {
    try {
      return await _repository.update(ids, payload);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(List<String?> ids) async {
    try {
      return await _repository.delete(ids);
    } catch (e) {
      rethrow;
    }
  }

  Future<Project> get(String id) async {
    try {
      return await _repository.get(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Project>> getAll() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      rethrow;
    }
  }
}
