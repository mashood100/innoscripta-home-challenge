import 'dart:convert' as convert;
import 'package:innoscripta_home_challenge/data/dto/task/task_dto.dart';
import 'package:innoscripta_home_challenge/data/source/network/task/tasks_api_service.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/domain/repository/task/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksApiService _api;

  TasksRepositoryImpl({
    required TasksApiService api,
  }) : _api = api;

  @override
  Future<Task> create(Task task) async {
    try {
      Map<String, dynamic> payload = task.toDto().toMap();
      payload.removeWhere((key, value) => value == null);

      final responseString = await _api.create(payload);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Task.fromDto(TaskDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> update(Task task) async {
    try {
      final responseString = await _api.update(task);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Task.fromDto(TaskDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(Task task) async {
    try {
      await _api.delete(task);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close(Task task) async {
    try {
      await _api.close(task);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> get(String id) async {
    try {
      final responseString = await _api.get(id);
      final Map<String, dynamic> responseBody =
          convert.jsonDecode(responseString);

      return Task.fromDto(TaskDto.fromMap(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> getAll(String projectId) async {
    try {
      final responseString = await _api.getAll(projectId);
      final List<dynamic> responseBody = convert.jsonDecode(responseString);

      var allTasks = responseBody
          .map((taskMap) => Task.fromDto(TaskDto.fromMap(taskMap)))
          .toList();
      return allTasks;
    } catch (e) {
      rethrow;
    }
  }
}
