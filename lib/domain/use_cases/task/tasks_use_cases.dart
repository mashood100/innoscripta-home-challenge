import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/tasks_repository.dart';

class TasksUseCases {
  TasksUseCases({
    required TasksRepository repository,
  }) : _repository = repository;

  final TasksRepository _repository;

  Future<Task> create(Task task) async {
    try {
      return await _repository.create(task);
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> update(Task task) async {
    try {
      return await _repository.update(task);
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

  Future<Task> get(String id) async {
    try {
      return await _repository.get(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getAll(String projectId) async {
    try {
      return await _repository.getAll(projectId);
    } catch (e) {
      rethrow;
    }
  }
}
