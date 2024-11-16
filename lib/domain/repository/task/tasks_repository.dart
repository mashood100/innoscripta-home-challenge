import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';

abstract class TasksRepository {
  Future<Task> create(Task task);
  Future<Task> update(Task task);
  Future<void> delete(List<String?> ids);
  Future<Task> get(String id);
  Future<List<Task>> getAll(String projectId);
}
